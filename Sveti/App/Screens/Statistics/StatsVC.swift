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
  }
}
