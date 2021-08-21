import Foundation

class EditTagGroupVC: VCwithTable {

  let groupId: String

  init(groupId: String) {
    self.groupId = groupId
    super.init(with: .insetGrouped)
    tableView = EditingTableView(viewModel: viewModel, style: .grouped)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func getDataProvider() -> TableDataProvider? {
    EditTagGroupTableDataProvider(with: groupId)
  }

  override func setViewModel(with dataProvider: TableDataProvider) {
    viewModel = EditTagGroupVM(tableDataProvider: dataProvider, tagGroupId: groupId)
    viewModel.delegate = self
  }


  override func setLayout() {
    super.setLayout()
    tableView.separatorColor = .clear
    tableView.isEditing = true
    tableView.eventDebounceValue = 0
    title = "Изменить"
    navigationItem.largeTitleDisplayMode = .never
  }
}

extension EditTagGroupVC: ViewControllerVMDelegate {
  func onNeedToUpdateContent() {
    DispatchQueue.main.async {
      guard let vm = self.viewModel as? EditTagGroupVM else { return }
      vm.generateCellsDataForTags()

      self.tableView.reloadData()
    }
  }
}
