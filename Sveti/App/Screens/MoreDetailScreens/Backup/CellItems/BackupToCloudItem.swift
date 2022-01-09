import UIKit

class BackupToCloudCellItem: ISimpleCellItem {

  var title: String

  var iconImage: UIImage?
  var iconTintColor: UIColor? = .white
  var iconBackgroundColor: UIColor? = #colorLiteral(red: 0.2049866915, green: 0.6625028849, blue: 0.5520762801, alpha: 1)
  var accessoryImage: UIImage? = UIImage(named: "sync")

  var onTapAction: (() -> Void)?

  init() {
    title = "Backup data to iCloud"

    onTapAction = {

    }
  }
}
