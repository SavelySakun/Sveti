import UIKit

class DiaryTagCollectionView: UICollectionView {

  var tags = [Tag]()
  var tagsBackColor: UIColor = .systemGray2

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    let collectionViewLayout = LeftAlignedCollectionViewFlowLayout()
    collectionViewLayout.minimumLineSpacing = 4
    collectionViewLayout.minimumInteritemSpacing = 8
    collectionViewLayout.estimatedItemSize = CGSize(width: 70, height: 27)

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
    cell.contentView.backgroundColor = tagsBackColor

    return cell
  }
}
