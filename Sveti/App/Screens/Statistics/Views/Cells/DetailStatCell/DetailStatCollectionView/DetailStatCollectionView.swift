import UIKit

class DetailStatCollectionView: UICollectionView {

  var items = [DetailStatItem]()

  init(frame: CGRect) {
    let collectionViewLayout = LeftAlignedCollectionViewFlowLayout()
    collectionViewLayout.minimumLineSpacing = CollectionViewSizeConstants.itemSpacing
    collectionViewLayout.minimumInteritemSpacing = CollectionViewSizeConstants.itemSpacing
    collectionViewLayout.estimatedItemSize = CGSize(width: 120.0, height: 42.0)

    super.init(frame: frame, collectionViewLayout: collectionViewLayout)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setLayout() {
    isScrollEnabled = false
    delegate = self
    dataSource = self
    backgroundColor = .systemGray6
    allowsMultipleSelection = true

    registerViews()
  }

  private func registerViews() {
    register(DetailStatCollectionCell.self, forCellWithReuseIdentifier: DetailStatCollectionCell.reuseId)
    register(NoDetailStatCell.self, forCellWithReuseIdentifier: NoDetailStatCell.reuseId)
  }
}

extension DetailStatCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.isEmpty ? 1 : items.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return items.isEmpty ? getNoDataCell(at: indexPath) : getDefaultCell(at: indexPath)
  }

  private func getNoDataCell(at indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = dequeueReusableCell(withReuseIdentifier: NoDetailStatCell.reuseId, for: indexPath) as? NoDetailStatCell else { return UICollectionViewCell() }
    return cell
  }

  private func getDefaultCell(at indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = dequeueReusableCell(withReuseIdentifier: DetailStatCollectionCell.reuseId, for: indexPath) as? DetailStatCollectionCell else { return UICollectionViewCell() }
    cell.setDetailStat(with: items[indexPath.row])
    return cell
  }
}
