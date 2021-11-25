import UIKit

class EditTagGroupsCell: Cell {

  private let titleLabel = UILabel()
  private let editButton = RoundButtonView(firstStateImage: "edit")

  override func setLayout() {

    titleLabel.text = "Настроение"
    editButton.backColor = .systemGray6
    editButton.imageView?.tintColor = .systemBlue

    contentView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { (make) in
      make.top.left.bottom.equalToSuperview().inset(UIUtils.middleOffset)
    }

    contentView.addSubview(editButton)
    editButton.snp.makeConstraints { (make) in
      make.left.equalTo(titleLabel.snp.right)
      make.centerY.equalTo(titleLabel.snp.centerY)
      make.right.equalToSuperview().offset(-UIUtils.defaultOffset)
    }
  }

}
