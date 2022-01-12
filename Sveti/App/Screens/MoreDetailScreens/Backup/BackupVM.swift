import Foundation
import Network

protocol BackupVMDelegate: AnyObject {
  func showCompleteAlert(title: String, message: String)
  func showErrorAlert(description: String)
}

class BackupVM: ViewControllerVM {

  private let networkMonitor = NWPathMonitor()
  private let backupManager = BackupManager()
  private let backgroundQueue = DispatchQueue.global(qos: .background)
  private var backupState: BackupState = .needToCheckBackupExistence

  weak var backupDelegate: BackupVMDelegate?

  override init(tableDataProvider: TableDataProvider? = nil) {
    super.init(tableDataProvider: tableDataProvider)
    setNetworkMonitor()
  }

  private func setNetworkMonitor() {
    networkMonitor.pathUpdateHandler = { pathUpdateHandler in
      if pathUpdateHandler.status == .satisfied {
        print("Internet connection is on.")
      } else {
        print("There's no internet connection.")
      }
    }
    networkMonitor.start(queue: backgroundQueue)
  }

  func loadBackup() {
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
    guard let error = error else { return }
    backupDelegate?.showErrorAlert(description: error)
  }

  private func handleBackupInfo(_ backupInfo: BackupInfo) {
    backupState = backupInfo.state
    tableDataProvider?.updateSections(with: backupInfo)
    delegate?.onNeedToUpdateContent()
    guard let alertInfo = backupInfo.state.generateTitleMessageForAlert() else { return }
    let (title, subtitle) = alertInfo
    backupDelegate?.showCompleteAlert(title: title, message: subtitle)
  }

  func updateBackup() {
    backgroundQueue.async { [self] in
      if backupState == .noBackupFound {
        backupManager.saveToCloudKit { backupManagerResultHandler($0, $1) }
      } else {
        backupManager.updateExistingBackupRecord { backupManagerResultHandler($0, $1) }
      }
    }
  }

  func restoreData() {
    backgroundQueue.async { self.backupManager.restoreBackup {
      self.backupManagerResultHandler($0, $1) }
    }
  }
}
