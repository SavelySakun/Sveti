import UIKit

class NonExistingTagsItem: SimpleCellItem {
  override init() {
    super.init()
    accessoryTintColor = .red
    title = "Remove non-existent tags from note"
    subtitle = "Tags that no longer exist: "
    accessoryImage = UIImage(named: "delete")?.withRenderingMode(.alwaysTemplate)
  }
}
