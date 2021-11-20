import UIKit
import MessageUI

class ContactDeveloperMoreItem: IMoreItem {
  var title: String = "Contact the developer"
  var iconBackgroundColor: UIColor = .systemPink
  var iconImage: UIImage? = UIImage(systemName: "quote.bubble.fill")
  var iconTintColor: UIColor = .white
  var onTapAction: (() -> Void)?

  init() {
    setOnTapAction()
  }

  private func setOnTapAction() {
    onTapAction = {
      guard let currentVC = CurrentVC.current else { return }
      let messageDeveloperVC = MessageDeveloperVC()
      currentVC.navigationController?.pushViewController(messageDeveloperVC, animated: true)
    }
  }
}
