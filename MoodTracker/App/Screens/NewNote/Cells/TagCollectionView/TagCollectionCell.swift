import UIKit

class TagCollectionCell: UICollectionViewCell {

	static let reuseId = "HashtagCollectionCell"
  let tagNameLabel = UILabel()
  let tagImageView = UIImageView()
  var offset = 10
  var betweenTextImageOffset = 8

	override init(frame: CGRect) {
		super.init(frame: frame)
		setLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

  func set(with tag: Tag) {
    tagNameLabel.text = tag.name
    let image = UIImage(named: tag.iconName)?.withRenderingMode(.alwaysTemplate)
    tagImageView.image = image
  }

  func setImageViewWithHeight() {
    tagImageView.snp.makeConstraints { (make) in
      make.width.height.equalTo(15)
    }
  }

  private func setImageView() {
    tagImageView.image = UIImage(named: "tag")?.withRenderingMode(.alwaysTemplate)
    tagImageView.contentMode = .scaleAspectFit
    setImageViewWithHeight()

    contentView.addSubview(tagImageView)
    tagImageView.snp.makeConstraints { (make) in
      make.left.equalToSuperview().offset(offset)
      make.top.equalToSuperview().offset(offset)
      make.bottom.equalToSuperview().offset(-offset)
    }
  }

  private func setLabel() {
    tagNameLabel.text = "отдых"
    tagNameLabel.sizeToFit()
    tagNameLabel.font = UIFont.systemFont(ofSize: 15)

    contentView.addSubview(tagNameLabel)
    tagNameLabel.snp.makeConstraints { (make) in
      make.left.equalTo(tagImageView.snp.right).offset(betweenTextImageOffset)
      make.centerY.equalToSuperview()
      make.right.equalToSuperview().offset(-offset)
    }
  }

	func setLayout() {
    contentView.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1).withAlphaComponent(0.4)
    contentView.layer.cornerRadius = 8

    setImageView()
    setLabel()
    setSelectedView()
	}

  private func setSelectedView() {
    let selectedView = UIView()
    selectedView.layer.cornerRadius = 8
    selectedView.backgroundColor = #colorLiteral(red: 0.3490196078, green: 0.5921568627, blue: 0.8039215686, alpha: 1).withAlphaComponent(0.25)
    selectedBackgroundView = selectedView
  }
}
