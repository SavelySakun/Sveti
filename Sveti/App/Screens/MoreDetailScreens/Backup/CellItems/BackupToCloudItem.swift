import UIKit

class BackupToCloudCellItem: SimpleCellItem {
  override init() {
    super.init()
    title = "Save data to the cloud".localized
    subtitleColor = #colorLiteral(red: 0.2049866915, green: 0.6625028849, blue: 0.5520762801, alpha: 1)
    iconTintColor = .white
    accessoryImage = UIImage(named: "sync")

    onTapAction = { publisher in
      publisher?.send(BackupEvent(type: .onUpdateBackup))
    }
  }
}
