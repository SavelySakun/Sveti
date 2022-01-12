import UIKit

class AboutMoreItem: SimpleCellItem {
  override init() {
    super.init()
    title = "About".localized
    iconBackgroundColor = .systemPurple
    iconImage = UIImage(named: "about")?.withRenderingMode(.alwaysTemplate)
    iconTintColor = .white
    onTapAction = {
      guard let currentVC = CurrentVC.current else { return }
      let contactDeveloperVC = AboutVC()
      currentVC.navigationController?.pushViewController(contactDeveloperVC, animated: true)
    }
  }
}
