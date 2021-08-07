import Foundation

class TagGroup {
  var title: String
  var tagIds: [String]

  init(title: String, tagIds: [String]) {
    self.title = title
    self.tagIds = tagIds
  }
}
