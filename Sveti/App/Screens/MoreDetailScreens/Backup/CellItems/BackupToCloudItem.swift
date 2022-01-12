import UIKit

class BackupToCloudCellItem: SimpleCellItem {
  override init() {
    super.init()

    title = "Save current data to the cloud"
    subtitleColor = #colorLiteral(red: 0.2049866915, green: 0.6625028849, blue: 0.5520762801, alpha: 1)
    iconTintColor = .white
    accessoryImage = UIImage(named: "sync")
    onTapAction = {
      guard let currentVC = CurrentVC.current as? BackupVC,
      let viewModel = currentVC.viewModel as? BackupVM else { return }
      viewModel.updateBackup()
    }
  }
}
