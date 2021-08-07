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
    tagsCollection.tagSelectionDelegate = self
    contentView.addSubview(tagsCollection)

    tagsCollection.snp.makeConstraints { (make) in
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

  override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
    tagsCollection.layoutIfNeeded()
    return tagsCollection.contentSize
  }
}

extension TagCell: TagCollectionViewDelegate {
  func onTagSelection(tagId: String) {
    let event = EditEvent(type: .tagChange, value: tagId)
    publisher.send(event)
  }
}
