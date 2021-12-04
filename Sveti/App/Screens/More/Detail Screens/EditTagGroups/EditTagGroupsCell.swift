import UIKit

class EditTagGroupsCell: Cell {

  private let titleLabel = UILabel()
  private let editButton = RoundButtonView(firstStateImage: "more")
  private let totalTagsCountView = TextOnRoundView()

  override func setLayout() {
    setTitleLabel()
    setEditButton()
    setTotalTagsCountView()
  }

  private func setTitleLabel() {
    contentView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { (make) in
      make.top.left.bottom.equalToSuperview().inset(UIUtils.middleOffset)
    }
  }

  private func setEditButton() {
    editButton.backColor = #colorLiteral(red: 0.1764705882, green: 0.6117647059, blue: 0.9882352941, alpha: 1).withAlphaComponent(0.7)
    editButton.imageView?.tintColor = .white
    contentView.addSubview(editButton)
    editButton.snp.makeConstraints { (make) in
      make.height.width.equalTo(32)
      make.centerY.equalTo(titleLabel.snp.centerY)
      make.right.equalToSuperview().offset(-UIUtils.defaultOffset)
    }
  }

  private func setTotalTagsCountView() {
    contentView.addSubview(totalTagsCountView)
    totalTagsCountView.backgroundColor = .systemGray5
    totalTagsCountView.snp.makeConstraints { (make) in
      make.left.equalTo(titleLabel.snp.right).offset(UIUtils.defaultOffset)
      make.centerY.equalTo(titleLabel.snp.centerY)
    }
  }

  override func configureSelf(with viewModel: CellVM) {
    guard let group = viewModel.cellValue as? TagGroup else { return }
    titleLabel.text = group.title
    totalTagsCountView.textLabel.text = String(group.tags.count)
  }

}
