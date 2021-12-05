import UIKit

class DiaryTagCell: TagCollectionCell {

  override func setLayout() {
    offset = 7
    betweenTextImageOffset = 6
    super.setLayout()
    contentView.layer.cornerRadius = 8
    tagNameLabel.textColor = .white
    tagNameLabel.font = UIFont.systemFont(ofSize: 14)
    backgroundView?.backgroundColor = .clear
    tagImageView.tintColor = .white
  }

  override func setImageViewWithHeight() {
    tagImageView.snp.makeConstraints { (make) in
      make.width.height.equalTo(13)
    }
  }
}
