import UIKit

class MoreCell: Cell {

  private let iconView = IconView()
  private let titleLabel = UILabel()
  var onTapAction: (() -> Void)?

  override func setLayout() {
    accessoryType = .disclosureIndicator

    contentView.addSubview(iconView)
    iconView.layer.cornerRadius = 8
    iconView.snp.makeConstraints { (make) in
      make.left.equalToSuperview().offset(UIUtils.defaultOffset)
      make.top.bottom.equalToSuperview().inset(UIUtils.middleOffset)
      make.height.width.equalTo(32)
    }

    contentView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { (make) in
      make.left.equalTo(iconView.snp.right).offset(UIUtils.defaultOffset)
      make.centerY.equalTo(iconView)
      make.right.equalToSuperview().offset(UIUtils.bigOffset)
    }
  }

  override func configureSelf(with viewModel: CellVM) {
    guard let moreItem = viewModel.cellValue as? IMoreItem else { return }
    iconView.backgroundColor = moreItem.iconBackgroundColor
    iconView.iconTintColor = moreItem.iconTintColor
    iconView.image = moreItem.iconImage
    titleLabel.text = moreItem.title
    onTapAction = moreItem.onTapAction
  }

}
