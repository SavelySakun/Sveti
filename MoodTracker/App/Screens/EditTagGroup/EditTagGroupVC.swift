import Foundation

class EditTagGroupVC: VCwithTable {

  let groupId: String

  init(groupId: String) {
    self.groupId = groupId
    super.init(with: .insetGrouped)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func getDataProvider() -> TableDataProvider? {
    EditTagGroupTableDataProvider(with: groupId)
  }

  override func setViewModel(with dataProvider: TableDataProvider) {
    viewModel = EditTagGroupVM(tableDataProvider: dataProvider, tagGroupId: groupId)
  }


  override func setLayout() {
    super.setLayout()
    tableView.separatorColor = .clear
    title = "Изменить"
    navigationItem.largeTitleDisplayMode = .never
  }
}
