import UIKit

class DownloadDataMoreItem: ISimpleCellItem {
  var title: String = "Download data"
  var iconBackgroundColor: UIColor? = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
  var iconImage: UIImage? = UIImage(named: "download")?.withRenderingMode(.alwaysTemplate)
  var iconTintColor: UIColor? = .white
  var accessoryImage: UIImage? = nil

  var onTapAction: (() -> Void)? = {
    guard let currentVC = CurrentVC.current else { return }
    let contactDeveloperVC = ContactDeveloperVC()
    currentVC.navigationController?.pushViewController(contactDeveloperVC, animated: true)
  }
}
