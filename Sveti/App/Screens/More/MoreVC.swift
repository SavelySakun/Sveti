import UIKit

class MoreVC: VCwithTable {
    override init(with tableStyle: UITableView.Style = .insetGrouped) {
        super.init(with: tableStyle)
        tableView = SimpleTableView(viewModel: viewModel)
    }

    override func logOpenScreenEvent() {
        SvetiAnalytics.log(.More)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setLayout() {
        super.setLayout()
        title = "More".localized
        tableView.backgroundColor = .systemGray6
    }

    override func getDataProvider() -> TableDataProvider? {
        return MoreTableDataProvider()
    }
}
