import UIKit

class EditTagGroupsMoreItem: ISimpleCellItem {
  var title: String = "Tag groups"
  var iconBackgroundColor: UIColor? = .systemBlue
  var iconImage: UIImage? = UIImage(named: "folder")?.withRenderingMode(.alwaysTemplate)
  var iconTintColor: UIColor? = .white

  var onTapAction: (() -> Void)? = {
    guard let currentVC = CurrentVC.current else { return }
    currentVC.navigationController?.pushViewController(EditTagGroupsVC(), animated: true)
  }
}
