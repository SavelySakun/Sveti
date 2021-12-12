import UIKit

protocol ISimpleCellItem: AnyObject {
  var title: String { get set }
  var iconImage: UIImage? { get set }
  var iconTintColor: UIColor? { get set }
  var iconBackgroundColor: UIColor? { get set }
  var onTapAction: (() -> Void)? { get set }
}
