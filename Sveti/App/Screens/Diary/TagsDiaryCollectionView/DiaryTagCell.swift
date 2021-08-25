import UIKit

class DiaryTagCell: TagCollectionCell {

  override func setLayout() {
    offset = 7
    betweenTextImageOffset = 6
    super.setLayout()
    contentView.backgroundColor = .clear
    let colorForTag: UIColor = .black.withAlphaComponent(0.8)
    tagNameLabel.textColor = colorForTag
    tagNameLabel.font = UIFont.systemFont(ofSize: 14)
  }

  override func setImageViewWithHeight() {
    tagImageView.snp.makeConstraints { (make) in
      make.width.height.equalTo(13)
    }
  }
}
