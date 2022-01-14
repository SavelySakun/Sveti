import Foundation

enum BackupEventType: String {
  case onUpdateBackup
  case onRestoreBackup
}

class BackupEvent: Event {
  init(type: BackupEventType) {
    super.init(type: type.rawValue, value: "")
  }
}
