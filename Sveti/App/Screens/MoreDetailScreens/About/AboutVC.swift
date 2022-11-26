import UIKit

class AboutVC: VCwithTable {
    override init(with tableStyle: UITableView.Style = .grouped) {
        super.init(with: tableStyle)
        tableView = SimpleTableView(viewModel: viewModel)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
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
