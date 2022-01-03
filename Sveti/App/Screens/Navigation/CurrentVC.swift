import UIKit

// Helper used for easy access for current VC from anywhere
class CurrentVC {
  static weak var past: UIViewController?
  static weak var current: UIViewController? {
    didSet { self.past = oldValue }
  }
}
