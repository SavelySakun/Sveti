import UIKit

class BackupVC: VCwithTable {

  override init(with tableStyle: UITableView.Style = .grouped) {
    super.init(with: tableStyle)
    tableView = TableViewWithTapAction(viewModel: viewModel)
  }

  private func configureBackupData() {
    guard let vm = viewModel as? BackupVM else { return }
    
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func setLayout() {
    super.setLayout()
    title = "Backup & Restore"
    tableView.backgroundColor = .systemGray6
  }

  override func getDataProvider() -> TableDataProvider? {
    return BackupTableDataProvider()
  }
}
