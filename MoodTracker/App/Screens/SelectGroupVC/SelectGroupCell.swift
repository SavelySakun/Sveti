import UIKit

class SelectGroupCell: Cell {
  private let groupNameTitleLabel = UILabel()

  override func setLayout() {
    accessoryType = .disclosureIndicator
    contentView.addSubview(groupNameTitleLabel)
    groupNameTitleLabel.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(UIUtils.middleOffset)
      make.left.equalToSuperview().offset(UIUtils.bigOffset)
      make.right.equalToSuperview().offset(-UIUtils.bigOffset)
      make.bottom.right.equalToSuperview().offset(-UIUtils.middleOffset)
    }
  }

  override func configureSelf(with viewModel: CellVM) {
    groupNameTitleLabel.text = viewModel.title
  }
}
