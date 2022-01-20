import RealmSwift
import Foundation

class Note: Object, Comparable {
  static func < (lhs: Note, rhs: Note) -> Bool {
    let leftDate = lhs.splitDate?.rawDate.timeIntervalSince1970 ?? 0.0
    let rightDate = rhs.splitDate?.rawDate.timeIntervalSince1970 ?? 1.0
    return leftDate < rightDate
  }

  @objc dynamic var id = Int(Date().timeIntervalSince1970)
  @objc dynamic var splitDate: SplitDate? = SplitDate(rawDate: Date())
  @objc dynamic var mood: Mood? = Mood()
  @objc dynamic var comment = String()
  var tags = List<Tag>()

  override static func primaryKey() -> String? {
    return "id"
  }
}
