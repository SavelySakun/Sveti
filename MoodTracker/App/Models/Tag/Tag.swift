import UIKit

class Tag {
  var id: String
  var name: String
  var iconName: String

  init(name: String, iconName: String = "tag", id: String) {
    self.name = name
    self.iconName = iconName
    self.id = id
  }
}
