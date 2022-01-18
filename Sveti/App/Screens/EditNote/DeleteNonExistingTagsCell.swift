import Foundation
import UIKit

class DeleteNonExistingTagsCell: SimpleCell {

  override func setLayout() {
    super.setLayout()
    selectionStyle = .none
  }

  override func configureSelf(with viewModel: CellVM) {
    super.configureSelf(with: viewModel)
    addActionToAccessory()
  }

  private func addActionToAccessory() {
    let gesture = UITapGestureRecognizer(target: self, action: #selector(onAccessoryTap))
    accessoryView?.addGestureRecognizer(gesture)
    accessoryView?.isUserInteractionEnabled = true
  }

  @objc private func onAccessoryTap() {
    onTapAction?(publisher)
  }
}
