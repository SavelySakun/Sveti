import Foundation
import UIKit

struct BackupInfo {
  let state: BackupState
  var lastBackupDate: Date? = nil
}

enum BackupState {
  case needToCheckBackupExistence
  case readyToRestoreBackup
  case successRestoreData
  case successBackupedToCloud

  case noBackupFound
  case noInternetConnection
  case needToAuthInICloud

  func getAlertInfo() -> (String, String, UIImage?)? {
    switch self {
    case .needToCheckBackupExistence, .readyToRestoreBackup, .noBackupFound, .noInternetConnection, .needToAuthInICloud:
      return nil
    case .successRestoreData:
      return ("Success", "All data has been restored", UIImage(systemName: "arrow.down.doc"))
    case .successBackupedToCloud:
      return ("Success", "All data has saved in cloud", UIImage(named: "cloud"))
    }
  }
}
