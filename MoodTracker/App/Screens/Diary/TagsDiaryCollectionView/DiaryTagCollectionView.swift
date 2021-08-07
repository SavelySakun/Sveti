import UIKit

class DiaryTagCollectionView: UICollectionView {

  var tagsIds = [String]()

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
    tagsIds.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    guard let cell = dequeueReusableCell(withReuseIdentifier: DiaryTagCell.reuseId, for: indexPath) as? DiaryTagCell else { return UICollectionViewCell() }

    let tagId = tagsIds[indexPath.row]
    if let tag = TagsRepository().getTag(with: tagId) {
      cell.set(with: tag)
    }

    return cell
  }
}
