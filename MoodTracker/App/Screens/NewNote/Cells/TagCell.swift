import UIKit

class TagCell: Cell {

  private let tagsCollection = TagCollectionView()
  private let searchField = UISearchTextField()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setLayout() {
    contentView.backgroundColor = .systemGray6
    
    addSearchField()
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

  private func addTagCollectionView() {
    tagsCollection.interactionDelegate = self
    contentView.addSubview(tagsCollection)

    tagsCollection.snp.makeConstraints { (make) in
      make.height.equalTo(getCollectionViewHeight())
      make.top.equalTo(searchField.snp.bottom).offset(UIUtils.middleOffset)
      make.left.equalTo(contentView.snp.left).offset(UIUtils.bigOffset)
      make.right.equalTo(contentView.snp.right).offset(-UIUtils.bigOffset)
      make.bottom.equalTo(contentView.snp.bottom).offset(-UIUtils.middleOffset)
    }
  }

  private func addSearchField() {
    searchField.placeholder = "Поиск тэгов"
    contentView.addSubview(searchField)
    searchField.snp.makeConstraints { (make) in
      make.height.equalTo(40)
      make.top.equalToSuperview().offset(UIUtils.defaultOffset)
      make.left.equalToSuperview().offset(UIUtils.defaultOffset)
      make.right.equalToSuperview().offset(-UIUtils.defaultOffset)
    }
  }

  func getCollectionViewHeight() -> Double {
    struct Section {
      var numberOfSections = 0.0
      var numberOfActiveFooters = 0.0
      var numberOfRows = 0.0
    }

    var section = Section()
    section.numberOfSections = Double(tagsCollection.tagGroups.count)

    tagsCollection.tagGroups.forEach { group in
      if group.isExpanded {
        let numberOfRows: Double = (Double(group.tagIds.count) / 3.0).rounded(.up)
        section.numberOfRows += numberOfRows
        section.numberOfActiveFooters += 1.0
      }
    }

    let sectionHeight = 46.0
    let footerHeight = 25.0

    let totalHeightOfSection = sectionHeight * section.numberOfSections
    let totalHeightOfFooters = footerHeight * section.numberOfActiveFooters

    let cellHeight = 35.0 + 4.0
    let totalCellHeight = cellHeight * section.numberOfRows
    
    let totalHeightOfCollectionView = totalHeightOfSection + totalHeightOfFooters + totalCellHeight
    return totalHeightOfCollectionView
  }

  override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
    let heightOffset = (UIUtils.middleOffset * 2) + UIUtils.defaultOffset + 40
    let size = CGSize(width: Double(self.frame.width), height: getCollectionViewHeight() + Double(heightOffset))
    return size
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
