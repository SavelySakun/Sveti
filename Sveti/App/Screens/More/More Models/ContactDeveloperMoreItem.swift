import UIKit
import MessageUI

class ContactDeveloperMoreItem: SimpleCellItem {
  override init() {
    super.init()
    title = "Contact us".localized
    iconBackgroundColor = UIColor.systemPink
    iconImage = UIImage(systemName: "quote.bubble.fill")?.withRenderingMode(.alwaysTemplate)
    iconTintColor = UIColor.white

    onTapAction = {
      guard let currentVC = CurrentVC.current else { return }
      let contactDeveloperVC = ContactDeveloperVC()
      currentVC.navigationController?.pushViewController(contactDeveloperVC, animated: true)
    }
  }
}
