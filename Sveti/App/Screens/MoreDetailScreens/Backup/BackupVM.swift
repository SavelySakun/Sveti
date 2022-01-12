import Foundation
import Network

protocol BackupVMDelegate: AnyObject {
  func showCompleteAlert(title: String, message: String)
  func showErrorAlert(description: String)
  func showLoadingIndicator()
  func stopLoadingIndicator()
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

  func loadBackup() {
    guard backupManager.isUserICloudAvailable() else {
      handleBackupInfo(BackupInfo(state: .needToAuthInICloud))
      return
    }
    backupDelegate?.showLoadingIndicator()
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
    backupDelegate?.stopLoadingIndicator()
    guard let error = error else { return }
    backupDelegate?.showErrorAlert(description: error)
  }

  private func handleBackupInfo(_ backupInfo: BackupInfo) {
    backupState = backupInfo.state
    lastBackupUpdate = backupInfo.lastBackupDate ?? self.lastBackupUpdate

    tableDataProvider?.updateSections(with: BackupInfo(state: backupInfo.state, lastBackupDate: backupInfo.lastBackupDate ?? self.lastBackupUpdate))

    delegate?.onNeedToUpdateContent()
    guard let alertInfo = backupInfo.state.generateTitleMessageForAlert() else { return }
    let (title, subtitle) = alertInfo
    backupDelegate?.showCompleteAlert(title: title, message: subtitle)
  }

  func updateBackup() {
    backupDelegate?.showLoadingIndicator()
    backgroundQueue.async { [self] in
      if backupState == .noBackupFound {
        backupManager.saveToCloudKit { backupManagerResultHandler($0, $1) }
      } else {
        backupManager.updateExistingBackupRecord { backupManagerResultHandler($0, $1) }
      }
    }
  }

  func restoreData() {
    backupDelegate?.showLoadingIndicator()
    backgroundQueue.async { self.backupManager.restoreBackup {
      self.backupManagerResultHandler($0, $1) }
    }
  }
}
