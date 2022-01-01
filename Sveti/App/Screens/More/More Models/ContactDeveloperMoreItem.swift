import UIKit
import MessageUI

class ContactDeveloperMoreItem: ISimpleCellItem {
  var title: String = "Contact us"
  var iconBackgroundColor: UIColor? = .systemPink
  var iconImage: UIImage? = UIImage(systemName: "quote.bubble.fill")
  var iconTintColor: UIColor? = .white
  var accessoryImage: UIImage? = nil

  var onTapAction: (() -> Void)? = {
    guard let currentVC = CurrentVC.current else { return }
    let contactDeveloperVC = ContactDeveloperVC()
    currentVC.navigationController?.pushViewController(contactDeveloperVC, animated: true)
  }
}
