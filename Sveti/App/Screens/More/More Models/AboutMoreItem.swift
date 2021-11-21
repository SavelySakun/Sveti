import UIKit

class AboutMoreItem: IMoreItem {
  var title: String = "About"
  var iconBackgroundColor: UIColor = .orange
  var iconImage: UIImage? = UIImage(named: "about")?.withRenderingMode(.alwaysTemplate)
  var iconTintColor: UIColor = .white
  var onTapAction: (() -> Void)?

  init() {
    setOnTapAction()
  }

  private func setOnTapAction() {
    onTapAction = {
      guard let currentVC = CurrentVC.current else { return }
      let contactDeveloperVC = ContactDeveloperVC()
      currentVC.navigationController?.pushViewController(contactDeveloperVC, animated: true)
    }
  }
}
