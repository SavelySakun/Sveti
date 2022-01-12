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

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateBackupInfo()
  }

  private func configureBackupData() {
    guard let vm = viewModel as? BackupVM else { return }
    vm.backupDelegate = self
    vm.delegate = self
  }

  private func updateBackupInfo() {
    guard let vm = viewModel as? BackupVM else { return }
    vm.loadBackup()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setActivityIndicator()
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
  func showLoadingIndicator() {
    DispatchQueue.main.async {
      self.activitiIndicator.startAnimating()
    }
  }

  func stopLoadingIndicator() {
    DispatchQueue.main.async {
      self.activitiIndicator.stopAnimating()
    }
  }

  func showCompleteAlert(title: String, message: String) {
    DispatchQueue.main.async {
      let alertView = SPAlertView(title: title, message: message, preset: .done)
      alertView.duration = 4
      alertView.present()
    }
  }

  func showErrorAlert(description: String) {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: "Error".localized, message: description, preferredStyle: .alert)
      let closeAction = UIAlertAction(title: "OK", style: .default) { _ in
        alert.dismiss(animated: true)
      }
      alert.addAction(closeAction)
      self.navigationController?.present(alert, animated: true)
    }
  }
}

extension BackupVC: ViewControllerVMDelegate {
  func onNeedToUpdateContent() {
    DispatchQueue.main.async { [self] in
      activitiIndicator.stopAnimating()
      UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve) {
        tableView.reloadData()
      }
    }
  }
}
