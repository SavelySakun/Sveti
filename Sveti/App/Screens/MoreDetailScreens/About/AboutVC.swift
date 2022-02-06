import UIKit

class AboutVC: VCwithTable {

  override init(with tableStyle: UITableView.Style = .grouped) {
    super.init(with: tableStyle)
    tableView = SimpleTableView(viewModel: viewModel)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func setLayout() {
    super.setLayout()
    title = "About".localized
    tableView.backgroundColor = .systemGray6
  }

  override func getDataProvider() -> TableDataProvider? {
    return AboutTableDataProvider()
  }
}
