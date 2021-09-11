import UIKit

class CurrentVC {
  static weak var past: UIViewController?
  static weak var current: UIViewController? {
    didSet { self.past = oldValue }
  }

  static func push(vc: UIViewController) {
    current?.navigationController?.pushViewController(vc, animated: true)
  }
}
