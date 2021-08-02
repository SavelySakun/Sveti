import UIKit

class HashtagCell: Cell {

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	fileprivate func setLayout() {

    let searchField = UISearchTextField()
    searchField.placeholder = "Поиск тэгов"

		let hashtagCollection = HashtagCollectionView()
    contentView.addSubview(searchField)
    contentView.addSubview(hashtagCollection)

    searchField.snp.makeConstraints { (make) in
      make.height.equalTo(40)
      make.top.equalToSuperview().offset(UIUtils.defaultOffset)
      make.left.equalToSuperview().offset(UIUtils.defaultOffset)
      make.right.equalToSuperview().offset(-UIUtils.defaultOffset)
    }

		hashtagCollection.snp.makeConstraints { (make) in
      make.height.equalTo(UIScreen.main.bounds.height * 0.25) // todo: сделать автоматическую высоту
      make.top.equalTo(searchField.snp.bottom).offset(16)
      make.left.equalTo(contentView.snp.left).offset(UIUtils.defaultOffset)
      make.right.equalTo(contentView.snp.right).offset(-UIUtils.defaultOffset)
      make.bottom.equalTo(contentView.snp.bottom).offset(-UIUtils.defaultOffset)
		}
	}

}
