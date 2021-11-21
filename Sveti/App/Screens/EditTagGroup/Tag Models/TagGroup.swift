import Foundation
import RealmSwift

class TagGroup: Object {
  @objc dynamic var id = String()
  @objc dynamic var title = String()
  @objc dynamic var isExpanded: Bool = true
  var tags = List<Tag>()

  convenience init(title: String, tags: [Tag]) {
    self.init()
    self.id = UUID().uuidString
    self.title = title
    tags.forEach { tag in
      self.tags.append(tag)
    }
  }
}
