import UIKit

class CurrentVC {
  static weak var current: UIViewController?

  static func push(vc: UIViewController) {
    current?.navigationController?.pushViewController(vc, animated: true)
  }
}
