import Combine
import Foundation
import Network
import UIKit

protocol InformationDelegate: AnyObject {
    func showUpdatedAlert()
    func showCompleteAlert(title: String, message: String, image: UIImage?)
    func showAlert(title: String?, message: String, actions: [UIAlertAction]?, completion: (() -> Void)?)
    func updateLoadingIndicator(show: Bool)
}

class BackupVM: ViewControllerVM {
    private let networkMonitor = NWPathMonitor()
    private let backupManager = BackupManager()
    private let backgroundQueue = DispatchQueue.global(qos: .background)
    private var backupState: BackupState = .needToCheckBackupExistence
    private var lastBackupUpdate: Date?

    weak var backupInformationDelegate: InformationDelegate?

    override init(tableDataProvider: TableDataProvider? = nil) {
        super.init(tableDataProvider: tableDataProvider)
        setNetworkMonitor()
    }

    private func setNetworkMonitor() {
        networkMonitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status != .satisfied {
                self.handleBackupInfo(BackupInfo(state: .noInternetConnection))
            }
        }
        networkMonitor.start(queue: backgroundQueue)
    }

    override func addSubscriber(newSub: AnyCancellable, with _: String) {
        subscribers.append(newSub)
    }

    override func handle<T>(_ event: T) where T: Event {
        super.handle(event)
        guard let event = event as? BackupEvent else { return }
        let eventType = BackupEventType(rawValue: event.type)
        switch eventType {
        case .onUpdateBackup:
            updateBackup()
        case .onRestoreBackup:
            prepareForRestoreData()
        case .onDeleteBackupFromCloud:
            deleteBackup()
        case .none:
            return
        }
    }

    // Loads backup file from CloudKit
    func loadBackup() {
        guard backupManager.isUserICloudAvailable() else {
            handleBackupInfo(BackupInfo(state: .needToAuthInICloud))
            return
        }
        backupInformationDelegate?.updateLoadingIndicator(show: true)
        backgroundQueue.async { self.backupManager.loadBackupFromCloudKit {
            self.backupManagerResultHandler($0, $1)
        }
        }
    }

    private func backupManagerResultHandler(_ backupInfo: BackupInfo?, _ error: String?) {
        guard error == nil, let backupInfo = backupInfo else {
            handleError(error)
            return
        }
        handleBackupInfo(backupInfo)
    }

    private func handleBackupInfo(_ backupInfo: BackupInfo) {
        trackBackupAnalytics(with: backupInfo.state)

        if backupInfo.state == .successDataRestore {
            StatDayContentManager.shared.needUpdateViews = true
        }

        subscribers.removeAll() // <- remove old subcribers to avoid event handle action dublication while reusing cells because overrided addSubscriber() does't check already subscribed cells

        backupState = backupInfo.state
        lastBackupUpdate = backupInfo.lastBackupDate ?? lastBackupUpdate

        tableDataProvider?.updateSections(with: BackupInfo(state: backupInfo.state, lastBackupDate: backupInfo.lastBackupDate ?? lastBackupUpdate))
        contentUpdateDelegate?.reloadContent()

        guard let alertInfo = backupInfo.state.getAlertInfo() else {
            backupInformationDelegate?.showUpdatedAlert()
            return
        }
        let (title, subtitle, image) = alertInfo
        backupInformationDelegate?.showCompleteAlert(title: title, message: subtitle, image: image)
    }

    private func trackBackupAnalytics(with state: BackupState) {
        guard let key = state.getAnalyticKey() else { return }
        SvetiAnalytics.log(key)
    }

    private func handleError(_ error: String?) {
        SvetiAnalytics.log(.backupError, params: ["backup_error_text": error ?? ""])
        backupInformationDelegate?.updateLoadingIndicator(show: false)
        guard let error = error else { return }
        backupInformationDelegate?.showAlert(title: "Error".localized, message: error, actions: nil, completion: nil)
    }

    func updateBackup() {
        backupInformationDelegate?.updateLoadingIndicator(show: true)
        backgroundQueue.async { [self] in
            if backupState == .noBackupFound || backupState == .backupDeleted {
                backupManager.createBackupInCloudKit { self.backupManagerResultHandler($0, $1) }
            } else {
                backupManager.updateExistingBackupRecord { self.backupManagerResultHandler($0, $1) }
            }
        }
    }

    func prepareForRestoreData() {
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel)
        let continueAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.restoreData()
        }
        backupInformationDelegate?.showAlert(title: "Attention".localized, message: "This action will replace all app content stored on the device".localized, actions: [cancelAction, continueAction], completion: nil)
    }

    private func restoreData() {
        backupInformationDelegate?.updateLoadingIndicator(show: true)
        backgroundQueue.async { self.backupManager.restoreBackup {
            self.backupManagerResultHandler($0, $1)
        }
        }
    }

    private func deleteBackup() {
        let deleteAction = UIAlertAction(title: "Delete".localized, style: .destructive) { _ in
            self.backupInformationDelegate?.updateLoadingIndicator(show: true)
            self.backgroundQueue.async {
                self.backupManager.deleteBackupFromCloudKit { self.backupManagerResultHandler($0, $1) }
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .default)
        backupInformationDelegate?.showAlert(title: "Attention".localized, message: "Cloud data will be deleted".localized, actions: [cancelAction, deleteAction], completion: nil)
    }
}
