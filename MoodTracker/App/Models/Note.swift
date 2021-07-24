import RealmSwift
import Foundation

class Note: Object {
  @objc dynamic var id = Int()
  @objc dynamic var date = Date()
  @objc dynamic var mood: Float = 6
  @objc dynamic var phys: Float = 6
  @objc dynamic var comment = String()
  var tags = List<String>()
}
