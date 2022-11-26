import UIKit

// Helper used for easy access for current VC from anywhere
class CurrentVC {
    weak static var past: UIViewController?
    weak static var current: UIViewController? {
        didSet { past = oldValue }
    }
}
