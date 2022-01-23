import UIKit

class NonTagGroupsItem: SimpleCellItem {
  override init() {
    super.init()
    title = "No tag groups exist"
    subtitle = "Please add your first tag group 🥺"
    backgroundColor = .systemGray6
    accessoryTintColor = .systemGray6
    showAccessory = false
  }
}
