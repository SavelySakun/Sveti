import UIKit

protocol ICellWithOnTapAction {
  var onTapAction: (() -> Void)? { get set }
}

class SimpleCell: Cell, ICellWithOnTapAction {

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
    guard let moreItem = viewModel.cellValue as? ISimpleCellItem else { return }
    titleLabel.text = moreItem.title
    onTapAction = moreItem.onTapAction

    guard let iconImage = moreItem.iconImage,
          let iconTintColor = moreItem.iconTintColor,
          let iconBackground = moreItem.iconBackgroundColor else {
      iconView.snp.makeConstraints { $0.width.equalTo(0) }
      return
    }

    iconView.backgroundColor = iconBackground
    iconView.iconTintColor = iconTintColor
    iconView.image = iconImage
  }
}
