import UIKit

class HashtagCollectionCell: UICollectionViewCell {

	static let reuseId = "HashtagCollectionCell"

	override init(frame: CGRect) {
		super.init(frame: frame)
		setLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	fileprivate func setLayout() {
    let tagContainer = UIView()
    tagContainer.backgroundColor = .systemGray5
    tagContainer.layer.cornerRadius = 9

    let label = UILabel()
    label.text = "Работа"

    tagContainer.addSubview(label)
		contentView.addSubview(tagContainer)

    tagContainer.snp.makeConstraints { (make) in
      make.top.equalToSuperview()
      make.left.equalToSuperview()
      make.bottom.right.equalToSuperview()
    }

    let offset = 8
		label.snp.makeConstraints { (make) in
      make.top.left.equalToSuperview().offset(offset)
      make.right.bottom.equalToSuperview().offset(-offset)
		}
	}

}
