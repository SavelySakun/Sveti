import Foundation

enum BackupError: String {
  case failedToLoadBackup
  case noIcloudAccountError
  case noBackupExist
  case noInternetConnection
  case errorBackup
}
