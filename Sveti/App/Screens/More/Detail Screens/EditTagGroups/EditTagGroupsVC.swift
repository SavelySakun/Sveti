import UIKit

class EditTagGroupsVC: VCwithTable {

  override init(with tableStyle: UITableView.Style = .insetGrouped) {
    super.init(with: tableStyle)
    tableView = EditTagGroupsTable(viewModel: viewModel)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func setLayout() {
    super.setLayout()
    title = "Edit tag groups"
    tableView.backgroundColor = .systemGray6
    tableView.isEditing = true
  }

  override func getDataProvider() -> TableDataProvider? {
    return EditTagGroupsTableDataProvider()
  }

}
