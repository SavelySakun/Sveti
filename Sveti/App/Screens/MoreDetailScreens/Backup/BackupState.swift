import Foundation

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

  func generateTitleMessageForAlert() -> (String, String)? {
    switch self {
    case .needToCheckBackupExistence:
      return nil
    case .readyToRestoreBackup:
      return nil
    case .successRestoreData:
      return ("Success", "All data has been restored")
    case .successBackupedToCloud:
      return ("Success", "All data has saved in cloud")
    case .noBackupFound:
      return nil
    case .noInternetConnection:
      return nil
    case .needToAuthInICloud:
      return nil
    }
  }
}
