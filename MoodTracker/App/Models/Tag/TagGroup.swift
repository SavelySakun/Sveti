import Foundation
import RealmSwift

class TagGroup: Object {
  @objc dynamic var id = String()
  @objc dynamic var title = String()
  @objc dynamic var isExpanded: Bool = true
  var tagIds = List<String>()

  convenience init(title: String, tagIds: [String]) {
    self.init()
    self.id = UUID().uuidString
    self.title = title
    tagIds.forEach { tag in
      self.tagIds.append(tag)
    }
  }
}
