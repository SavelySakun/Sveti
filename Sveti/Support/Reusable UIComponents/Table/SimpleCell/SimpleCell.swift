import UIKit
import Combine

class BackupCell: SimpleCell {
  
}

protocol ICellWithOnTapAction {
  var onTapAction: ((PassthroughSubject<Event, Never>?) -> Void)? { get set }
}

class SimpleCell: Cell, ICellWithOnTapAction {

  private let iconView = IconView()
  private let titleLabel = UILabel()
  private let subtitleLabel = UILabel()
  private var cellItem: ISimpleCellItem?

  var onTapAction: ((PassthroughSubject<Event, Never>?) -> Void)?

  override func setLayout() {
    setStyles()

    contentView.addSubview(iconView)
    iconView.layer.cornerRadius = 8
    iconView.snp.makeConstraints { (make) in
      make.left.equalToSuperview().offset(UIUtils.defaultOffset)
      make.top.equalToSuperview().inset(UIUtils.defaultOffset)
      make.height.width.equalTo(32)
    }

    let titlesStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
    titlesStackView.axis = .vertical
    titlesStackView.spacing = 10
    contentView.addSubview(titlesStackView)

    titlesStackView.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(UIUtils.bigOffset)
      make.left.equalTo(iconView.snp.right).offset(UIUtils.defaultOffset)
      make.right.equalToSuperview().offset(-UIUtils.bigOffset)
      make.bottom.equalToSuperview().offset(-UIUtils.bigOffset)
    }
  }

  private func setStyles() {
    subtitleLabel.font = UIFont.systemFont(ofSize: 14)
    subtitleLabel.numberOfLines = 0
  }

  override func configureSelf(with viewModel: CellVM) {
    guard let cellItem = viewModel.cellValue as? ISimpleCellItem else { return }
    self.cellItem = cellItem

    titleLabel.text = cellItem.title
    titleLabel.textColor = cellItem.titleColor ?? .black

    subtitleLabel.text = cellItem.subtitle
    onTapAction = cellItem.onTapAction
    subtitleLabel.textColor = cellItem.subtitleColor ?? .systemGray2
    isUserInteractionEnabled = cellItem.isActive
    backgroundColor = cellItem.backgroundColor

    setIcon()
    setAccessory()
  }

  private func setIcon() {
    guard let cellItem = self.cellItem,
          let iconImage = cellItem.iconImage else {
      iconView.snp.makeConstraints { $0.width.equalTo(0) }
      return
    }

    iconView.image = iconImage
    remakeIconViewConstraints()

    if let iconTintColor = cellItem.iconTintColor {
      iconView.iconTintColor = iconTintColor
    }
    if let iconBackground = cellItem.iconBackgroundColor {
      iconView.backgroundColor = iconBackground
    }
  }

  private func remakeIconViewConstraints() {
    iconView.snp.remakeConstraints { make in
      make.left.equalToSuperview().offset(UIUtils.defaultOffset)
      make.top.equalToSuperview().inset(UIUtils.defaultOffset)
      make.height.width.equalTo(32)
    }
  }

  private func setAccessory() {
    guard let cellItem = self.cellItem else { return }

    if let accessoryImage = cellItem.accessoryImage {
      let image = accessoryImage.withRenderingMode(.alwaysTemplate)
      let imageView = UIImageView(image: image)
      imageView.tintColor = cellItem.accessoryTintColor ?? .systemGray3
      accessoryView = imageView
      let accessoryWidthHeight = 22
      accessoryView?.bounds = CGRect(x: 0, y: 0, width: accessoryWidthHeight, height: accessoryWidthHeight)
    } else {
      accessoryView = nil
      accessoryType = .disclosureIndicator
    }
  }
}
