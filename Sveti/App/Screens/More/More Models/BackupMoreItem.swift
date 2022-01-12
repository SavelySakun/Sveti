import UIKit

class BackupMoreItem: SimpleCellItem {
  override init() {
    super.init()
    title = "Backup & restore data"
    iconBackgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    iconImage = UIImage(systemName: "cloud.fill")
    iconTintColor = UIColor.white

    onTapAction = {
      guard let currentVC = CurrentVC.current else { return }
      let backupVC = BackupVC()
      currentVC.navigationController?.pushViewController(backupVC, animated: true)
    }
  }
}
