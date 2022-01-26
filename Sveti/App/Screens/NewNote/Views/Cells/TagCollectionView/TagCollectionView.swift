import UIKit
import RealmSwift

protocol TagCollectionViewDelegate: AnyObject {
  func onTagSelection(tag: Tag)
  func onSectionExpandCollapse()
}

class TagCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {

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

  let realm = try! Realm()

  weak var interactionDelegate: TagCollectionViewDelegate?

  let tagsRepository = TagsRepository()
  lazy var tagGroups = tagsRepository.groups

  var selectedTags = [Tag]()
  var isSearchMode = false

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {

    let collectionViewLayout = LeftAlignedCollectionViewFlowLayout()
    collectionViewLayout.minimumLineSpacing = CollectionViewSizeConstants.itemSpacing
    collectionViewLayout.minimumInteritemSpacing = CollectionViewSizeConstants.itemSpacing
    collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    collectionViewLayout.headerReferenceSize = CGSize(width: frame.width, height: CollectionViewSizeConstants.sectionHeaderHeight)
    collectionViewLayout.footerReferenceSize = CGSize(width: frame.width, height: CollectionViewSizeConstants.sectionFooterHeight)

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
    register(TagCollectionCell.self, forCellWithReuseIdentifier: TagCollectionCell.reuseId)
    register(TextCollectionCell.self, forCellWithReuseIdentifier: TextCollectionCell.reuseId)

    register(TagSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TagSectionHeaderView.identifier)
    register(TagSectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: TagSectionFooterView.identifier)
  }

  func deselectAllItems() {
    indexPathsForSelectedItems?.forEach { deselectItem(at: $0, animated: false) }
  }
}

extension TagCollectionView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // If there is no active tags in section -> return 1 for "NoTagsInGroupCell"
    if tagGroups[section].isExpanded {
      return hasActiveTags(in: section) ? getDefaultNumberOfItems(in: section) : 1
    } else {
      return 0
    }
  }

  private func getDefaultNumberOfItems(in section: Int) -> Int {
    if isSearchMode {
      return tagGroups[section].tags.count
    } else {
      let isExpanded = tagGroups[section].isExpanded
      return isExpanded ? tagsRepository.getActiveTagsCount(in: section) : 0
    }
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    tagGroups.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // If no active tags -> show "NoTagsInGroupCell"
    return hasActiveTags(in: indexPath.section) ? getDefaultTagCell(at: indexPath) : getNoTagsInGroupCell(at: indexPath)
  }

  private func getDefaultTagCell(at indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = dequeueReusableCell(withReuseIdentifier: TagCollectionCell.reuseId, for: indexPath) as? TagCollectionCell else { return UICollectionViewCell() }

    let tag: Tag

    if isSearchMode {
      tag = tagGroups[indexPath.section].tags[indexPath.row]
    } else {
      tag = tagsRepository.getActiveTags(in: indexPath.section)[indexPath.row]
    }

    cell.set(with: tag)
    cell.isSelected = selectedTags.contains(tag)

    if selectedTags.contains(where: { $0.id == tag.id }) {
      DispatchQueue.main.async {
        self.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
      }
    }

    return cell
  }

  private func getNoTagsInGroupCell(at indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = dequeueReusableCell(withReuseIdentifier: TextCollectionCell.reuseId, for: indexPath) as? TextCollectionCell else { return UICollectionViewCell() }
    cell.textLabel.text = isSearchMode ? "Nothing found" : "No active tags"
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

    switch kind {

    case UICollectionView.elementKindSectionHeader:
      guard let sectionHeader = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TagSectionHeaderView.identifier, for: indexPath) as? TagSectionHeaderView else { return .init(frame: .zero) }

      sectionHeader.delegate = self
      sectionHeader.section = indexPath.section

      let group = tagGroups[indexPath.section]
      let groupTitle = group.title
      sectionHeader.set(with: groupTitle, isExpanded: group.isExpanded, isSearchMode: isSearchMode)

      return sectionHeader

    case UICollectionView.elementKindSectionFooter:
      guard let sectionFooter = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TagSectionFooterView.identifier, for: indexPath) as? TagSectionFooterView else { return .init(frame: .zero) }
      sectionFooter.isLastSection = (tagGroups.count - 1) == indexPath.section
      return sectionFooter

    default:
      return .init(frame: .zero)
    }
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    let isExpanded = tagGroups[section].isExpanded
    if isExpanded {
      return CGSize(width: frame.width, height: CollectionViewSizeConstants.sectionFooterHeight)
    } else {
      return CGSize(width: frame.width, height: 0)
    }
  }

  private func hasActiveTags(in section: Int) -> Bool {
    if isSearchMode {
      return !(tagGroups.last?.tags.isEmpty ?? true)
    } else {
      return tagsRepository.getActiveTagsCount(in: section) >= 1
    }
  }
}

extension TagCollectionView: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard hasActiveTags(in: indexPath.section) else { return }
    onTagSelect(with: indexPath)
  }

  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    guard hasActiveTags(in: indexPath.section) else { return }
    onTagSelect(with: indexPath)
  }

  func onTagSelect(with indexPath: IndexPath) {
    let tag = tagGroups[indexPath.section].tags[indexPath.row]
    selectedTags.append(tag)
    interactionDelegate?.onTagSelection(tag: tag)
  }
}

extension TagCollectionView: TagSectionHeaderViewDelegate {
  func onCollapseButtonTap(in section: Int) {
    tagsRepository.updateExpandStatus(groupIndex: section)
    updateCollectionLayoutAndData()
  }

  func onDoneTagGroupEdit() {
    tagGroups = TagsRepository().groups
    updateCollectionLayoutAndData()
  }

  private func updateCollectionLayoutAndData() {
    DispatchQueue.main.async { [self] in
      reloadData()
      interactionDelegate?.onSectionExpandCollapse()
    }
  }
}
