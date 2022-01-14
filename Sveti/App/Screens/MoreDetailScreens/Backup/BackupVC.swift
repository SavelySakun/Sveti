import UIKit
import SPAlert
import SPIndicator

class BackupVC: VCwithTable {

  private lazy var refreshControl = UIRefreshControl()

  override init(with tableStyle: UITableView.Style = .grouped) {
    super.init(with: tableStyle)
    guard let dataProvider = getDataProvider() else { return }
    setViewModel(with: dataProvider)
    tableView = SimpleTableView(viewModel: viewModel)
    configureBackupData()
  }

  private func configureBackupData() {
    guard let vm = viewModel as? BackupVM else { return }
    vm.backupDelegate = self
    vm.delegate = self
    loadBackupData()
  }

  private func loadBackupData() {
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
    setRefreshControl()
    setSyncNavButton()
  }

  override func getDataProvider() -> TableDataProvider? {
    return BackupTableDataProvider()
  }

  override func setViewModel(with dataProvider: TableDataProvider) {
    viewModel = BackupVM(tableDataProvider: dataProvider)
  }

  private func setSyncNavButton() {
    let button = UIButton()
    button.snp.makeConstraints { (make) in
      make.height.width.equalTo(28)
    }
    let image = UIImage(named: "syncCloud")?.withRenderingMode(.alwaysTemplate)
    button.setImage(image, for: .normal)
    button.addTarget(self, action: #selector(refresh), for: .touchUpInside)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
  }

  private func setRefreshControl() {
    refreshControl.tintColor = .systemGray3
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    tableView.refreshControl = refreshControl
  }

  @objc func refresh() {
    tableView.refreshControl?.endRefreshing()
    loadBackupData()
  }
}

extension BackupVC: BackupVMDelegate {
  func showUpdatedAlert() {
    DispatchQueue.main.async {
      SPIndicator.present(title: "Updated", message: nil, preset: .done, from: .top, completion: nil)
    }
  }
  
  func showCompleteAlert(title: String, message: String, image: UIImage?) {
    DispatchQueue.main.async {
      let preset: SPAlertIconPreset
      if let existingImage = image {
        preset = .custom(existingImage.withRenderingMode(.alwaysTemplate))
      } else {
        preset = .done
      }
      let alertView = SPAlertView(title: title, message: message, preset: preset)
      alertView.duration = 2.5
      alertView.present()
    }
  }

  func showAlert(title: String?, message: String, actions: [UIAlertAction]?) {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      if let actions = actions {
        actions.forEach { alert.addAction($0) }
      } else {
        alert.addAction(UIAlertAction(title: "OK", style: .default))
      }
      self.navigationController?.present(alert, animated: true)
    }
  }

  func updateLoadingIndicator(show: Bool) {
    DispatchQueue.main.async { [self] in
      show ? activitiIndicator.startAnimating() : activitiIndicator.stopAnimating()
    }
  }
}

extension BackupVC: ViewControllerVMDelegate {
  func onNeedToUpdateContent() {
    DispatchQueue.main.async { [self] in
      activitiIndicator.stopAnimating()
      UIView.transition(with: tableView, duration: 0.2, options: .transitionCrossDissolve) {
        tableView.reloadData()
      }
    }
  }
}
