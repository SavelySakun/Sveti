import UIKit

class BackupMoreItem: ISimpleCellItem {
  var title: String = "Backup & restore data"
  var iconBackgroundColor: UIColor? = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
  var iconImage: UIImage? = UIImage(systemName: "cloud.fill")
  var iconTintColor: UIColor? = .white
  var accessoryImage: UIImage?

  var onTapAction: (() -> Void)? = {
    guard let currentVC = CurrentVC.current else { return }
    let backupVC = BackupVC()
    currentVC.navigationController?.pushViewController(backupVC, animated: true)
  }
}
