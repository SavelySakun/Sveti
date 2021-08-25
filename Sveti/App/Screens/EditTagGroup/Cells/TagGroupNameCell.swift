import UIKit

class TagGroupNameCell: Cell {

  private let containerView = UIView()
  private let groupNameTextField = UITextField()
  private var groupId = String()

  override func configureSelf(with viewModel: CellVM) {
    super.configureSelf(with: viewModel)
    guard let groupId = viewModel.cellValue as? String,
          let group = TagsRepository().getGroup(with: groupId) else { return }
    self.groupId = groupId
    groupNameTextField.text = group.title
  }

  override func setLayout() {
    setContainerView()
    setTextField()
  }

  private func setContainerView() {
    containerView.backgroundColor = .systemGray6
    containerView.layer.cornerRadius = 12
    contentView.addSubview(containerView)
    containerView.snp.makeConstraints { (make) in
      make.top.equalToSuperview()
      make.left.equalToSuperview().offset(UIUtils.middleOffset)
      make.bottom.equalToSuperview()
      make.right.equalToSuperview().offset(-UIUtils.middleOffset)
    }
  }

  private func setTextField() {
    groupNameTextField.delegate = self
    containerView.addSubview(groupNameTextField)
    groupNameTextField.snp.makeConstraints { (make) in
      make.top.left.equalToSuperview().offset(UIUtils.middleOffset)
      make.right.bottom.equalToSuperview().offset(-UIUtils.middleOffset)
    }
  }
}

extension TagGroupNameCell: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let newName = textField.text else { return }
    TagsRepository().renameGroup(with: groupId, newName: newName)
  }
}
