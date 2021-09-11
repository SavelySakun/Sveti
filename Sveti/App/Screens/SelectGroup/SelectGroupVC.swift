import UIKit

class SelectGroupVC: VCwithTable {

  var editingGroupId = String()
  var moovingTagId = String()
  var onSelectionCompletion: ((String) -> Void) = { _ in return }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    view.snp.makeConstraints { (make) in
      make.height.equalTo(tableView.contentSize.height + 70.0)
    }
  }

  init(with groupId: String) {
    self.editingGroupId = groupId
    super.init(with: .insetGrouped)
    let selectGroupTableView = SelectGroupTableView(viewModel: viewModel, style: .insetGrouped)
    selectGroupTableView.groupSelectDelegate = self
    tableView = selectGroupTableView
  }

  override func getDataProvider() -> TableDataProvider? {
    let dataProvider = SelectGroupTableDataProvider(with: editingGroupId)
    return dataProvider
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SelectGroupVC: SelectGroupTableViewDelegate {
  func onSelectGroup(with id: String) {
    let tagsRepository = TagsRepository()
    tagsRepository.moveTagTo(newGroupId: id, tagId: moovingTagId)
    onSelectionCompletion(tagsRepository.getGroup(with: id)?.title ?? "новая")
  }

}
