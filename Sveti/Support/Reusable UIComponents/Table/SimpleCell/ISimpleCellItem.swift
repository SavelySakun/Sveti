import Combine
import UIKit

protocol ISimpleCellItem: AnyObject {
    var title: String? { get set }
    var titleColor: UIColor? { get set }
    var subtitle: String? { get set }
    var subtitleColor: UIColor? { get set }
    var iconImage: UIImage? { get set }
    var iconTintColor: UIColor? { get set }
    var iconBackgroundColor: UIColor? { get set }
    var accessoryImage: UIImage? { get set }
    var accessoryTintColor: UIColor? { get set }
    var onTapAction: ((PassthroughSubject<Event, Never>?) -> Void)? { get set }
    var isActive: Bool { get set }
    var backgroundColor: UIColor { get set }
    var showAccessory: Bool { get set }
}
