import UIKit

class DiaryTagCollectionView: UICollectionView {

  // Need to calculate height of collection view
  override var contentSize: CGSize {
    didSet {
      invalidateIntrinsicContentSize()
    }
  }

  override var intrinsicContentSize: CGSize {
    layoutIfNeeded()
    return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
  }

  var tags = [Tag]()

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    let collectionViewLayout = LeftAlignedCollectionViewFlowLayout()
    collectionViewLayout.minimumLineSpacing = 4
    collectionViewLayout.minimumInteritemSpacing = 0
    collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

    super.init(frame: frame, collectionViewLayout: collectionViewLayout)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setLayout() {
    delegate = self
    dataSource = self
    backgroundColor = .clear
    registerViews()
  }

  private func registerViews() {
    register(DiaryTagCell.self, forCellWithReuseIdentifier: TagCollectionCell.reuseId)
  }

}

extension DiaryTagCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    tags.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    guard let cell = dequeueReusableCell(withReuseIdentifier: DiaryTagCell.reuseId, for: indexPath) as? DiaryTagCell else { return UICollectionViewCell() }

    let tag = tags[indexPath.row]
    cell.set(with: tag)

    return cell
  }
}
