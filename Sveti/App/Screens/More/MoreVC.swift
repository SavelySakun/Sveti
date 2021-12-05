import UIKit
import MessageUI

class MoreVC: VCwithTable, MFMailComposeViewControllerDelegate {

  override init(with tableStyle: UITableView.Style = .insetGrouped) {
    super.init(with: tableStyle)
    tableView = MoreTableView(viewModel: viewModel)
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

