import UIKit

class RestoreFromCloudCellItem: ISimpleCellItem {

  var title: String

  var iconImage: UIImage?
  var iconTintColor: UIColor? = .white
  var iconBackgroundColor: UIColor?
  var accessoryImage: UIImage? = UIImage(systemName: "square.and.arrow.down")

  var onTapAction: (() -> Void)?

  init() {
    title = "Restore data"

    onTapAction = {
      let queue = DispatchQueue.global(qos: .background)

      queue.async {
        BackupManager().loadBackupFromCloudKit()
        //BackupManager().restoreRealmFromCloud()
      }
    }
  }
}
