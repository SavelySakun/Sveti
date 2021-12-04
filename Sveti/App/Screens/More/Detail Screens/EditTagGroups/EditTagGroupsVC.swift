import UIKit

class EditTagGroupsVC: VCwithTable {

  override init(with tableStyle: UITableView.Style = .insetGrouped) {
    super.init(with: tableStyle)
    tableView = EditTagGroupsTable(viewModel: viewModel)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    updateContent()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func setLayout() {
    super.setLayout()
    title = "Tag groups"
    tableView.backgroundColor = .systemGray6
    tableView.allowsSelectionDuringEditing = true
    tableView.isEditing = true
  }

  override func getDataProvider() -> TableDataProvider? {
    return EditTagGroupsTableDataProvider()
  }

  override func updateContent() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
}
