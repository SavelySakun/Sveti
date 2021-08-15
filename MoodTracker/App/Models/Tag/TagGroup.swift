import Foundation

class TagGroup {
  var id: String
  var title: String
  var tagIds: [String]
  var isExpanded: Bool = true

  init(title: String, tagIds: [String]) {
    self.id = UUID().uuidString
    self.title = title
    self.tagIds = tagIds
  }
}
