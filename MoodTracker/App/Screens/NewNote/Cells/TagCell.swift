import UIKit

private struct Section {
  var numberOfSections = 0.0
  var numberOfActiveFooters = 0.0
  var numberOfRows = 0.0
}

class TagCell: Cell {
  private let containerView = UIView()
  private let tagsCollection = TagCollectionView()
  private let searchBar = UISearchBar()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setLayout() {
    addSearchField()
    setContainerView()
    addTagCollectionView()
  }

  override func configureSelf(with viewModel: CellVM) {
    super.configureSelf(with: viewModel)

    if let note = viewModel.cellValue as? Note {
      let selectedTagIds = note.tags
      tagsCollection.selectedTagsIds = Array(selectedTagIds)
      tagsCollection.reloadData()
    } else {
      tagsCollection.deselectAllItems()
    }
  }

  private func addSearchField() {
    searchBar.delegate = self
    searchBar.searchBarStyle = .default
    searchBar.placeholder = "Поиск"
    searchBar.searchTextField.autocapitalizationType = .none
    searchBar.searchTextField.backgroundColor = .systemGray6
    searchBar.layer.borderWidth = 2
    searchBar.layer.cornerRadius = 12
    searchBar.layer.borderColor = UIColor.white.cgColor

    contentView.addSubview(searchBar)
    let offset = 8
    searchBar.snp.makeConstraints { (make) in
      make.height.equalTo(45)
      make.top.equalToSuperview()
      make.left.equalToSuperview().offset(-offset)
      make.right.equalToSuperview().offset(offset)
    }
  }

  private func setContainerView() {
    containerView.backgroundColor = .systemGray6
    containerView.layer.cornerRadius = 12

    contentView.addSubview(containerView)
    containerView.snp.makeConstraints { (make) in
      make.top.equalTo(searchBar.snp.bottom).offset(UIUtils.defaultOffset)
      make.left.equalToSuperview()
      make.bottom.equalToSuperview()
      make.right.equalToSuperview()
    }
  }


  private func addTagCollectionView() {
    tagsCollection.interactionDelegate = self
    containerView.addSubview(tagsCollection)

    tagsCollection.snp.makeConstraints { (make) in
      make.height.equalTo(getCollectionViewHeight())
      make.top.equalTo(containerView.snp.top).offset(UIUtils.middleOffset)
      make.left.equalTo(containerView.snp.left).offset(UIUtils.bigOffset)
      make.right.equalTo(containerView.snp.right).offset(-UIUtils.bigOffset)
      make.bottom.equalTo(containerView.snp.bottom).offset(-UIUtils.middleOffset)
    }
  }

  private func getCollectionViewHeight() -> Double {
    var section = Section()

    // 1. Get number of sections
    section.numberOfSections = Double(tagsCollection.tagGroups.count)

    // 2. Get total number of rows
    tagsCollection.tagGroups.forEach { group in
      if group.isExpanded {
        let numberOfRows: Double = (Double(group.tagIds.count) / 3.0).rounded(.up)
        section.numberOfRows += numberOfRows
        section.numberOfActiveFooters += 1.0
      }
    }

    // 3. Calculate total height of CollectionView
    let headerHeight = Double(CollectionViewSizeConstants.sectionHeaderHeight)
    let footerHeight = Double(CollectionViewSizeConstants.sectionFooterHeight)
    let cellHeight = CollectionViewSizeConstants.cellHeight + Double((CollectionViewSizeConstants.itemSpacing / 2.0))

    let totalHeightOfSections = headerHeight * section.numberOfSections
    let totalHeightOfFooters = footerHeight * section.numberOfActiveFooters
    let totalCellsHeight = cellHeight * section.numberOfRows
    
    return totalHeightOfSections + totalHeightOfFooters + totalCellsHeight
  }

  override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
    let heightOffset = (UIUtils.middleOffset * 2) + UIUtils.defaultOffset + 40
    let size = CGSize(width: Double(self.frame.width), height: getCollectionViewHeight() + Double(heightOffset))
    return size
  }
}

extension TagCell: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    let tagsRepository = TagsRepository()

    if searchText.isEmpty {
      tagsCollection.isSearchMode = false
      tagsCollection.nothingFoundLabel.isHidden = true
      tagsCollection.tagGroups = tagsRepository.tagGroups
    } else {
      let findTagIds = tagsRepository.getTagIds(with: searchText)
      tagsCollection.nothingFoundLabel.isHidden = !findTagIds.isEmpty
      tagsCollection.isSearchMode = true
      tagsCollection.tagGroups = [TagGroup(title: "Результат поиска", tagIds: findTagIds)]
    }

    DispatchQueue.main.async {
      self.tagsCollection.reloadData()
      self.delegate?.onUpdate()
    }
  }
}

extension TagCell: TagCollectionViewDelegate {
  func onTagSelection(tagId: String) {
    let event = EditEvent(type: .tagChange, value: tagId)
    publisher.send(event)
  }

  func onSectionExpandCollapse() {
    delegate?.onUpdate()
  }
}
