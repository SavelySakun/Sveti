import UIKit

class NavigationHelper {
  static weak var currentVC: UIViewController?

  static func push(vc: UIViewController) {
    currentVC?.navigationController?.pushViewController(vc, animated: true)
  }
}
