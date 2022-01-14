import UIKit

class DeleteBackupCellItem: SimpleCellItem {
  override init() {
    super.init()
    title = "Delete cloud save"
    subtitle = "This action cannot be undone"
    iconTintColor = .red
    accessoryImage = UIImage(named: "delete")?.withRenderingMode(.alwaysTemplate)

    onTapAction = { publisher in
      publisher?.send(BackupEvent(type: .onDeleteBackupFromCloud))
    }
  }
}
