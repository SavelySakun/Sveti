import Foundation
import RealmSwift

class Tag: Object {
  @objc dynamic var id = String()
  @objc dynamic var name = String()
  @objc dynamic var iconName = String()

  convenience init(name: String, iconName: String = "tag", id: String? = nil) {
    self.init()
    self.name = name
    self.iconName = iconName
    self.id = id ?? UUID().uuidString
  }
}
