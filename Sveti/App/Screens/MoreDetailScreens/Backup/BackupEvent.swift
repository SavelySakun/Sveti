import Foundation

enum BackupEventType: String {
  case onUpdateBackup
  case onRestoreBackup
  case onDeleteBackupFromCloud
}

class BackupEvent: Event {
  init(type: BackupEventType) {
    super.init(type: type.rawValue, value: "")
  }
}
