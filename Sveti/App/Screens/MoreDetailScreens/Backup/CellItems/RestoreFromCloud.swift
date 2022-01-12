import UIKit

class RestoreFromCloudCellItem: SimpleCellItem {
  override init() {
    super.init()
    title = "Restore data"
    iconTintColor = .white
    accessoryImage = UIImage(systemName: "square.and.arrow.down")
    onTapAction = {
      guard let currentVC = CurrentVC.current as? BackupVC,
      let viewModel = currentVC.viewModel as? BackupVM else { return }
      viewModel.restoreData()
    }
  }
}
