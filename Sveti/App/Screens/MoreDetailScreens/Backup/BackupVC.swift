import SPAlert
import SPIndicator
import UIKit

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
        vm.backupInformationDelegate = self
        vm.contentUpdateDelegate = self
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

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setLayout() {
        super.setLayout()
        title = "Backup & restore".localized
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
        button.snp.makeConstraints { make in
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

extension BackupVC: ViewControllerVMDelegate {
    func reloadContent() {
        DispatchQueue.main.async { [self] in
            activitiIndicator.stopAnimating()
            UIView.transition(with: tableView, duration: 0.2, options: .transitionCrossDissolve) {
                tableView.reloadData()
            }
        }
    }
}
