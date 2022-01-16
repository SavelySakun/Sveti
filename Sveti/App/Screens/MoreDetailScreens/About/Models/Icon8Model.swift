import UIKit

class Icon8Model: SimpleCellItem {
  override init() {
    super.init()
    accessoryImage = UIImage(named: "globe")
    title = "Icons by Icons8 💛".localized
    onTapAction = { _ in
      guard let url = URL(string: "https://icons8.com/") else { return }
      UIApplication.shared.open(url)
    }
  }
}
