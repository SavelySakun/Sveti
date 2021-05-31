import UIKit

class HashtagCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {


	override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		let collectionViewLayout = UICollectionViewFlowLayout()
		collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		collectionViewLayout.minimumInteritemSpacing = 14
		collectionViewLayout.minimumLineSpacing = 16
		collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
		super.init(frame: frame, collectionViewLayout: collectionViewLayout)
		setLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	fileprivate func setLayout() {
		delegate = self
		dataSource = self
		backgroundColor = .white
		register(HashtagCollectionCell.self, forCellWithReuseIdentifier: HashtagCollectionCell.reuseId)
		register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderView.reuseId)
	}

}

extension HashtagCollectionView: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		20
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		1
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = dequeueReusableCell(withReuseIdentifier: HashtagCollectionCell.reuseId, for: indexPath) as? HashtagCollectionCell else { return UICollectionViewCell()}
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		switch kind {
		case UICollectionView.elementKindSectionHeader:
			let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderView.reuseId, for: indexPath)
			return reusableview
		default:
			fatalError("Unexpected element kind")
		}
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

		return CGSize(width: self.frame.width, height: 60)
	}

}

extension HashtagCollectionView: UICollectionViewDelegate {
	
}
