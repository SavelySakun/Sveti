import UIKit

class TagGroupCell: Cell {

  private let tagNameLabel = UILabel()

  override func configureSelf(with viewModel: CellVM) {
    guard let tagId = viewModel.cellValue as? String else { return }
    let tag = TagsRepository().getTag(with: tagId)
    tagNameLabel.text = tag?.name
  }

  override func setLayout() {
    contentView.addSubview(tagNameLabel)
    tagNameLabel.snp.makeConstraints { (make) in
      make.top.equalToSuperview()
      make.left.equalToSuperview()
      make.bottom.equalToSuperview()
      make.right.equalToSuperview()
    }
  }
}

