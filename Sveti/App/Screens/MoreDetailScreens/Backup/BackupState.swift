import Foundation
import UIKit

struct BackupInfo {
  let state: BackupState
  var lastBackupDate: Date? = nil
}

enum BackupState {
  case needToCheckBackupExistence
  case readyToRestoreBackup
  case successDataRestore
  case successBackupedToCloud

  case noBackupFound
  case noInternetConnection
  case needToAuthInICloud
  case backupDeleted

  func getAlertInfo() -> (String, String, UIImage?)? {
    switch self {
    case .needToCheckBackupExistence, .readyToRestoreBackup, .noBackupFound, .noInternetConnection, .needToAuthInICloud:
      return nil
    case .successDataRestore:
      return ("Success".localized, "All data has been restored".localized, UIImage(systemName: "arrow.down.doc"))
    case .successBackupedToCloud:
      return ("Success".localized, "All data has saved in cloud".localized, UIImage(named: "cloud"))
    case .backupDeleted:
      return ("Success".localized, "All data has been deleted".localized, nil)
    }
  }
}
