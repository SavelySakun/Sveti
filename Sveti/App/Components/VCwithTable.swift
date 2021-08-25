import UIKit

class VCwithTable: BaseViewController {

  var viewModel: ViewControllerVM!
  var tableView: TableView!

  init(with tableStyle: UITableView.Style = .insetGrouped) {
    super.init(nibName: nil, bundle: nil)
    guard let dataProvider = getDataProvider() else { return }
    setViewModel(with: dataProvider)
    tableView = TableView(viewModel: viewModel, style: tableStyle)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setLayout()
  }

  func getDataProvider() -> TableDataProvider? {
    return TableDataProvider(with: nil)
  }

  func setViewModel(with dataProvider: TableDataProvider) {
    viewModel = ViewControllerVM(tableDataProvider: dataProvider)
  }

  func setLayout() {
    addTableToSuperview()
  }

  private func addTableToSuperview() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.top.left.bottom.right.equalToSuperview()
    }
  }

}
