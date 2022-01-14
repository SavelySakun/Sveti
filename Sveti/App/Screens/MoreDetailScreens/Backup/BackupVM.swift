import Foundation
import Network
import UIKit
import Combine

protocol BackupVMDelegate: AnyObject {
  func showUpdatedAlert()
  func showCompleteAlert(title: String, message: String, image: UIImage?)
  func showAlert(title: String?, message: String, actions: [UIAlertAction]?)
  func updateLoadingIndicator(show: Bool)
}

class BackupVM: ViewControllerVM {

  private let networkMonitor = NWPathMonitor()
  private let backupManager = BackupManager()
  private let backgroundQueue = DispatchQueue.global(qos: .background)
  private var backupState: BackupState = .needToCheckBackupExistence
  private var lastBackupUpdate: Date?

  weak var backupDelegate: BackupVMDelegate?

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

  override func addSubscriber(newSub: AnyCancellable, with cellIdentifier: String) {
    subscribers.append(newSub)
  }

  override func handle<T>(_ event: T) where T : Event {
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
    backupDelegate?.updateLoadingIndicator(show: true)
    backgroundQueue.async { self.backupManager.loadBackupFromCloudKit {
      self.backupManagerResultHandler($0, $1) }
    }
  }

  private func backupManagerResultHandler(_ backupInfo: BackupInfo?, _ error: String?) {
    guard error == nil, let backupInfo = backupInfo else {
      self.handleError(error)
      return
    }
    self.handleBackupInfo(backupInfo)
  }

  private func handleError(_ error: String?) {
    backupDelegate?.updateLoadingIndicator(show: false)
    guard let error = error else { return }
    backupDelegate?.showAlert(title: "Error".localized, message: error, actions: nil)
  }

  func updateBackup() {
    backupDelegate?.updateLoadingIndicator(show: true)
    backgroundQueue.async { [self] in
      if backupState == .noBackupFound || backupState == .backupDeleted {
        backupManager.saveToCloudKit { backupManagerResultHandler($0, $1) }
      } else {
        backupManager.updateExistingBackupRecord { backupManagerResultHandler($0, $1) }
      }
    }
  }

  func prepareForRestoreData() {
    let cancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel)
    let continueAction = UIAlertAction(title: "OK", style: .default) { _ in
      self.restoreData()
    }
    backupDelegate?.showAlert(title: "Attention", message: "This action will replace all app content stored on the device", actions: [cancelAction, continueAction])
  }

  private func restoreData() {
    backupDelegate?.updateLoadingIndicator(show: true)
    backgroundQueue.async { self.backupManager.restoreBackup {
      self.backupManagerResultHandler($0, $1) }
    }
  }

  private func handleBackupInfo(_ backupInfo: BackupInfo) {
    subscribers.removeAll() // <- remove old subcribers to avoid event handle action dublication while reusing cells because overrided addSubscriber() does't check already subscribed cells

    backupState = backupInfo.state
    lastBackupUpdate = backupInfo.lastBackupDate ?? self.lastBackupUpdate

    tableDataProvider?.updateSections(with: BackupInfo(state: backupInfo.state, lastBackupDate: backupInfo.lastBackupDate ?? self.lastBackupUpdate))

    delegate?.onNeedToUpdateContent()
    guard let alertInfo = backupInfo.state.getAlertInfo() else {
      backupDelegate?.showUpdatedAlert()
      return
    }
    let (title, subtitle, image) = alertInfo

    backupDelegate?.showCompleteAlert(title: title, message: subtitle, image: image)
  }

  private func deleteBackup() {
    let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
      self.backupDelegate?.updateLoadingIndicator(show: true)
      self.backgroundQueue.async {
        self.backupManager.deleteBackupFromCloudKit { self.backupManagerResultHandler($0, $1) }
      }
    }

    let cancelAction = UIAlertAction(title: "Cancel", style: .default)
    backupDelegate?.showAlert(title: "Attention", message: "Cloud data will be deleted", actions: [cancelAction, deleteAction])
  }
}
