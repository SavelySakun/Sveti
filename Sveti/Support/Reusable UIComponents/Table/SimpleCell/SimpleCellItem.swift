import Combine
import UIKit

class SimpleCellItem: ISimpleCellItem {
    var accessoryTintColor: UIColor?
    var titleColor: UIColor?
    var backgroundColor: UIColor = .white
    var isActive: Bool = true
    var title: String?
    var subtitle: String?
    var subtitleColor: UIColor?
    var iconImage: UIImage?
    var iconTintColor: UIColor?
    var iconBackgroundColor: UIColor?
    var accessoryImage: UIImage?
    var onTapAction: ((PassthroughSubject<Event, Never>?) -> Void)?
    var showAccessory: Bool = true
}
