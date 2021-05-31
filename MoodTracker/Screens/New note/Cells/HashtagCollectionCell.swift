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
		let label = UILabel()
		label.text = "#РАБота"

		contentView.addSubview(label)
		label.snp.makeConstraints { (make) in
			make.top.left.right.bottom.equalToSuperview()
		}
	}

}
