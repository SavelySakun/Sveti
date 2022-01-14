import UIKit

class RestoreFromCloudCellItem: SimpleCellItem {
  override init() {
    super.init()
    title = "Restore data"
    subtitleColor = .systemRed
    iconTintColor = .white
    accessoryImage = UIImage(systemName: "square.and.arrow.down")

    onTapAction = { publisher in
      publisher?.send(BackupEvent(type: .onRestoreBackup))
    }
  }
}
