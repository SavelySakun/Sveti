import UIKit

class NonExistingTagsItem: SimpleCellItem {
    override init() {
        super.init()
        backgroundColor = .systemGray6
        accessoryTintColor = .red
        title = "Remove non-existent tags from note".localized
        subtitle = "Tags that no longer exist: ".localized
        accessoryImage = UIImage(named: "delete")?.withRenderingMode(.alwaysTemplate)
    }
}
