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

  override func setLayout() {
    addSearchField()
    setContainerView()
    addTagCollectionView()
  }

  override func configureSelf(with viewModel: CellVM) {
    super.configureSelf(with: viewModel)

    if let note = viewModel.cellValue as? Note {
      tagsCollection.selectedTags = Array(note.tags)
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
      make.top.equalTo(containerView.snp.top).offset(UIUtils.middleOffset)
      make.left.equalTo(containerView.snp.left).offset(UIUtils.bigOffset)
      make.right.equalTo(containerView.snp.right).offset(-UIUtils.bigOffset)
      make.bottom.equalTo(containerView.snp.bottom).offset(-UIUtils.middleOffset)
    }
  }

  func getCollectionViewHeight() -> CGFloat {
    return tagsCollection.intrinsicContentSize.height
  }

  override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
    let heightOffset = (UIUtils.middleOffset * 2) + UIUtils.defaultOffset + 40
    let size = CGSize(width: Double(self.frame.width), height: Double(getCollectionViewHeight()) + Double(heightOffset))
    return size
  }
}

extension TagCell: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    let tagsRepository = TagsRepository()

    if searchText.isEmpty {
      tagsCollection.isSearchMode = false
      tagsCollection.nothingFoundLabel.isHidden = true
      tagsCollection.tagGroups = tagsRepository.groups
    } else {
      let findTagIds = tagsRepository.getTags(with: searchText)
      tagsCollection.nothingFoundLabel.isHidden = !findTagIds.isEmpty
      tagsCollection.isSearchMode = true
      tagsCollection.tagGroups = [TagGroup(title: "Результат поиска", tags: findTagIds)]
    }

    DispatchQueue.main.async {
      self.tagsCollection.reloadData()
      self.delegate?.onUpdate()
    }
  }
}

extension TagCell: TagCollectionViewDelegate {
  func onTagSelection(tag: Tag) {
    let event = EditEvent(type: .tagChange, value: tag)
    publisher.send(event)
  }

  func onSectionExpandCollapse() {
    delegate?.onUpdate()
  }
}
