import Foundation
import RealmSwift

class Tag: Object {
    @objc dynamic var id = String()
    @objc dynamic var name = String()
    @objc dynamic var iconName = String()
    @objc dynamic var isHidden = false

    convenience init(name: String, iconName: String = "tag", id: String? = nil, isHidden: Bool = false) {
        self.init()
        self.name = name
        self.iconName = iconName
        self.id = id ?? UUID().uuidString
        self.isHidden = isHidden
    }
}
