import UIKit

class HashtagCell: TableViewCell {

	static let reuseId = "HashtagCell"
	let viewModel: CellVM = MoodCellVM()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	fileprivate func setLayout() {

		let hashtagCollection = HashtagCollectionView()
		contentView.addSubview(hashtagCollection)

		hashtagCollection.snp.makeConstraints { (make) in
			make.height.width.equalTo(180)
			make.top.left.equalToSuperview().offset(UIUtils.defaultOffset)
			make.right.bottom.equalToSuperview().offset(-UIUtils.defaultOffset)
		}
	}

}
