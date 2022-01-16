import UIKit

class EditTagGroupsMoreItem: SimpleCellItem {
  override init() {
    super.init()
    title = "Tag groups".localized
    iconBackgroundColor = .systemBlue
    iconImage = UIImage(named: "folder")?.withRenderingMode(.alwaysTemplate)
    iconTintColor = .white

    onTapAction = { _ in
      guard let currentVC = CurrentVC.current else { return }
      currentVC.navigationController?.pushViewController(EditTagGroupsVC(), animated: true)
    }
  }
}
