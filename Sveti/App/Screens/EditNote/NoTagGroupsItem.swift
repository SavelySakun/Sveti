import UIKit

class NonTagGroupsItem: SimpleCellItem {
    override init() {
        super.init()
        title = "No tag groups exist".localized
        subtitle = "Please add your first tag group 🥺".localized
        backgroundColor = .systemGray6
        accessoryTintColor = .systemGray6
        showAccessory = false
    }
}
