import UIKit

class SelectGroupVC: VCwithTable {
  var moovingTagId = String()
  var onSelectionCompletion: ((String) -> Void) = { _ in return }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    view.snp.makeConstraints { (make) in
      make.height.equalTo(tableView.contentSize.height + 70.0)
    }
  }

  init() {
    super.init(with: .insetGrouped)
    let selectGroupTableView = SelectGroupTableView(viewModel: viewModel, style: .insetGrouped)
    selectGroupTableView.groupSelectDelegate = self
    tableView = selectGroupTableView
  }

  override func getDataProvider() -> TableDataProvider? {
    return SelectGroupTableDataProvider()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SelectGroupVC: SelectGroupTableViewDelegate {
  func onSelectGroup(in section: Int) {
    let tagsRepository = TagsRepository()
    tagsRepository.moveTagTo(section: section, with: moovingTagId)
    onSelectionCompletion(tagsRepository.groups[section].title)
  }
}
