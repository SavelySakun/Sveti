import UIKit

class CollectionHeaderView: UICollectionReusableView {

	static let reuseId = "HeaderView"

	override init(frame: CGRect) {
		super.init(frame: frame)
		setLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	fileprivate func setLayout() {
		let searchField = UISearchTextField()
		addSubview(searchField)
		searchField.snp.makeConstraints { (make) in
			make.top.left.equalToSuperview().offset(UIUtils.defaultOffset)
			make.right.bottom.equalToSuperview().offset(-UIUtils.defaultOffset)
		}
	}

}
