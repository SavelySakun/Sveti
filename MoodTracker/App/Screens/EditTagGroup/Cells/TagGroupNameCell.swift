import UIKit

class TagGroupNameCell: Cell {

  private let groupNameTextField = UITextField()

  override func configureSelf(with viewModel: CellVM) {
    super.configureSelf(with: viewModel)
    guard let groupId = viewModel.cellValue as? String,
          let group = TagsRepository().getGroup(with: groupId) else { return }
    groupNameTextField.text = group.title
  }

  override func setLayout() {
    setContentView()
    setTextField()
  }

  private func setContentView() {
    contentView.backgroundColor = .systemGray6
    contentView.layer.cornerRadius = 12
  }

  private func setTextField() {
    groupNameTextField.font = UIFont.systemFont(ofSize: 18)
    contentView.addSubview(groupNameTextField)
    groupNameTextField.snp.makeConstraints { (make) in
      make.top.left.equalToSuperview().offset(UIUtils.middleOffset)
      make.right.bottom.equalToSuperview().offset(-UIUtils.middleOffset)
    }
  }
  
}


