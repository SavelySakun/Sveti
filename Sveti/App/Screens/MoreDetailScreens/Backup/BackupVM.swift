import Foundation

class BackupVM: ViewControllerVM {

  private let backupManager = BackupManager()
  private let backgroundQueue = DispatchQueue.global(qos: .background)

  private func loadBackupFromCloudKit() {
    backgroundQueue.async {
      self.backupManager.loadBackupFromCloudKit()
    }
  }

}
