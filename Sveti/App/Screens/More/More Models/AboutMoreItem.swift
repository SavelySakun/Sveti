import UIKit

class AboutMoreItem: ISimpleCellItem {
  var title: String = "About"
  var iconBackgroundColor: UIColor? = .systemPurple
  var iconImage: UIImage? = UIImage(named: "about")?.withRenderingMode(.alwaysTemplate)
  var iconTintColor: UIColor? = .white
  var accessoryImage: UIImage? = nil

  var onTapAction: (() -> Void)? = {
    guard let currentVC = CurrentVC.current else { return }
    let contactDeveloperVC = AboutVC()
    currentVC.navigationController?.pushViewController(contactDeveloperVC, animated: true)
  }
}
