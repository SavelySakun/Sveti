import UIKit
import Charts

class StatsVC: VCwithTable {

  override init(with tableStyle: UITableView.Style = .insetGrouped) {
    super.init(with: tableStyle)
    guard let dataProvider = getDataProvider() else { return }
    setViewModel(with: dataProvider)
    tableView = StatsTableView(viewModel: viewModel, style: .insetGrouped)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    updateContent()
  }

  override func updateContent() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func getDataProvider() -> TableDataProvider? {
    return StatsTableDataProvider()
  }

  override func setLayout() {
    super.setLayout()
    title = "Statistics"
    setNavigationBar()
  }

  override func setViewModel(with dataProvider: TableDataProvider) {
    viewModel = StatsVM(tableDataProvider: dataProvider)
  }

  private func setNavigationBar() {
    let button = UIButton()
    button.snp.makeConstraints { (make) in
      make.height.width.equalTo(25)
    }
    let image = UIImage(named: "filterSettings")?.withRenderingMode(.alwaysTemplate)
    button.setTitleColor(.red, for: .selected)
    button.setImage(image, for: .normal)
    button.addTarget(self, action: #selector(showStatAverageSettings), for: .touchUpInside)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
  }

  @objc func showStatAverageSettings() {

  }
}
