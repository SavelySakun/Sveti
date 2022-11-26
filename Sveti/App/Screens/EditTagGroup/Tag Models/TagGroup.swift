import Foundation
import RealmSwift

class TagGroup: Object {
    @objc dynamic var id = String()
    @objc dynamic var title = String()
    @objc dynamic var isExpanded: Bool = true
    var tags = List<Tag>()

    convenience init(title: String, tags: [Tag], id: String = UUID().uuidString) {
        self.init()
        self.id = id
        self.title = title
        tags.forEach { tag in
            self.tags.append(tag)
        }
    }
}
