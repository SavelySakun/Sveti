import UIKit

class DetailTagsCell: Cell {

  private let tagsListView = SvetiTagListView()

  override func setLayout() {
    contentView.backgroundColor = .systemGray6
    setTagListView()
  }

  private func setTagListView() {
    contentView.addSubview(tagsListView)
    tagsListView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview().inset(UIUtils.defaultOffset)
    }
  }

  override func configureSelf(with viewModel: CellVM) {
    guard let note = viewModel.cellValue as? Note else { return }
    tagsListView.setTags(from: note)
    tagsListView.layoutIfNeeded()
  }
}
