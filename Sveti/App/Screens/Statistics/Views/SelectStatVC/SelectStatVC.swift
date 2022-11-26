import UIKit

class SelectStatVC: VCwithTable {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.snp.makeConstraints { make in
            make.height.equalTo(tableView.contentSize.height + 70.0)
        }
    }

    init() {
        super.init(with: .insetGrouped)
        tableView = SelectStatTableView(viewModel: viewModel)
    }

    override func getDataProvider() -> TableDataProvider? {
        let dataProvider = SelectStatTableDataProvider()
        return dataProvider
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setLayout() {
        super.setLayout()
        tableView.backgroundColor = .systemGray6
        tableView.tableHeaderView = SelectStatTableHeaderView(frame: .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.25))
    }
}
