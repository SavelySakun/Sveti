import UIKit

class EditTagGroupsMoreItem: IMoreItem {
  var title: String = "Edit tag groups"
  var iconBackgroundColor: UIColor = .systemBlue
  var iconImage: UIImage? = UIImage(named: "folder")?.withRenderingMode(.alwaysTemplate)
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
