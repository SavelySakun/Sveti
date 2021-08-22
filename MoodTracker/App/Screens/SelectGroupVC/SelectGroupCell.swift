import UIKit

class SelectGroupCell: Cell {
  private let groupNameTitleLabel = UILabel()

  override func setLayout() {
    accessoryType = .disclosureIndicator
    groupNameTitleLabel.text = "Досуг"
    contentView.addSubview(groupNameTitleLabel)
    groupNameTitleLabel.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(UIUtils.defaultOffset)
      make.left.equalToSuperview().offset(UIUtils.bigOffset)
      make.right.equalToSuperview().offset(-UIUtils.bigOffset)
      make.bottom.right.equalToSuperview().offset(-UIUtils.defaultOffset)
    }
  }
}
