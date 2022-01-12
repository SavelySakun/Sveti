import UIKit
import SPAlert

class BackupVC: VCwithTable {

  override init(with tableStyle: UITableView.Style = .grouped) {
    super.init(with: tableStyle)
    guard let dataProvider = getDataProvider() else { return }
    setViewModel(with: dataProvider)
    tableView = TableViewWithTapAction(viewModel: viewModel)
    configureBackupData()
  }

  private func configureBackupData() {
    guard let vm = viewModel as? BackupVM else { return }
    vm.loadBackup()
    vm.backupDelegate = self
    vm.delegate = self
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

  override func setViewModel(with dataProvider: TableDataProvider) {
    viewModel = BackupVM(tableDataProvider: dataProvider)
  }
}

extension BackupVC: BackupVMDelegate {
  func showCompleteAlert(title: String, message: String) {
    let alertView = SPAlertView(title: title, message: message, preset: .done)
    alertView.duration = 2
    alertView.present()
  }

  func showErrorAlert(description: String) {
    let alertView = SPAlertView(title: "Error".localized, message: description, preset: .error)
    alertView.duration = 3
    alertView.present()
  }
}

extension BackupVC: ViewControllerVMDelegate {
  func onNeedToUpdateContent() {
    DispatchQueue.main.async { [self] in
      UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve) {
        tableView.reloadData()
      }
    }
  }
}
