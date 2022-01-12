import UIKit

class RestoreFromCloudCellItem: SimpleCellItem {
  override init() {
    super.init()
    title = "Restore data"
    subtitle = "Attention: this action will replace all app content stored on the device"
    subtitleColor = .systemRed
    iconTintColor = .white
    accessoryImage = UIImage(systemName: "square.and.arrow.down")
    onTapAction = {
      guard let currentVC = CurrentVC.current as? BackupVC,
      let viewModel = currentVC.viewModel as? BackupVM else { return }
      viewModel.restoreData()
    }
  }
}
