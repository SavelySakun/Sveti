import UIKit

class Icon8Model: ISimpleCellItem {

  var title: String

  var iconImage: UIImage? = nil
  var iconTintColor: UIColor? = nil
  var iconBackgroundColor: UIColor? = nil
  var accessoryImage: UIImage? = UIImage(named: "globe")

  var onTapAction: (() -> Void)?

  init() {
    title = "Icons by Icons8 💛".localized

    onTapAction = {
      guard let url = URL(string: "https://icons8.com/") else { return }
      UIApplication.shared.open(url)
    }
  }
}
