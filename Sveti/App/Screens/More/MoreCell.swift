import UIKit

class MoreCell: Cell {

  private let iconView = IconView()
  private let titleLabel = UILabel()

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
    backgroundColor = .systemGray6
    iconView.backgroundColor = .systemPink
    iconView.image = UIImage(systemName: "quote.bubble.fill")?.withRenderingMode(.alwaysTemplate)
    titleLabel.text = "Contact the developer"
  }

}
