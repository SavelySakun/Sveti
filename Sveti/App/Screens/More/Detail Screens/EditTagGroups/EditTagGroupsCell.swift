import UIKit

class EditTagGroupsCell: Cell {

  private let titleLabel = UILabel()
  private let editButton = RoundButtonView(firstStateImage: "more")
  private let totalTagsCountView = TextOnRoundView()

  override func setLayout() {
    selectionStyle = .default
    setTotalTagsCountView()
    setTitleLabel()
    setEditButton()
  }

  private func setTotalTagsCountView() {
    contentView.addSubview(totalTagsCountView)
    totalTagsCountView.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.6117647059, blue: 0.9882352941, alpha: 1).withAlphaComponent(0.7)
    totalTagsCountView.textLabel.textColor = .white
    totalTagsCountView.textLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    totalTagsCountView.snp.makeConstraints { (make) in
      make.left.equalToSuperview().offset(UIUtils.defaultOffset)
      make.centerY.equalTo(contentView.snp.centerY)
    }
  }

  private func setTitleLabel() {
    contentView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { (make) in
      make.top.bottom.equalToSuperview().inset(UIUtils.middleOffset)
      make.left.equalTo(totalTagsCountView.snp.right).offset(UIUtils.defaultOffset)
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
    editButton.isHidden = true
  }

  override func configureSelf(with viewModel: CellVM) {
    guard let group = viewModel.cellValue as? TagGroup else { return }
    titleLabel.text = group.title
    totalTagsCountView.textLabel.text = String(group.tags.count)
  }

}
