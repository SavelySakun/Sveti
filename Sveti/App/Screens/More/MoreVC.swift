import UIKit

class MoreVC: VCwithTable {

  override init(with tableStyle: UITableView.Style = .insetGrouped) {
    super.init(with: tableStyle)
    tableView = TableViewWithTapAction(viewModel: viewModel)
  }

  override func logOpenScreenEvent() {
    SvetiAnalytics.log(.More)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func setLayout() {
    super.setLayout()
    title = "More"
    tableView.backgroundColor = .systemGray6
  }

  override func getDataProvider() -> TableDataProvider? {
    return MoreTableDataProvider()
  }

}

