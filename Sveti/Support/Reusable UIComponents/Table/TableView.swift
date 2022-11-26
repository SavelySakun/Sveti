import Combine
import UIKit

class TableView: UITableView {
    let viewModel: ViewControllerVM
    var sections: [TableSection] {
        viewModel.tableDataProvider!.sections!
    }

    var eventDebounceValue = 0.1

    init(viewModel: ViewControllerVM, style: UITableView.Style = .insetGrouped) {
        self.viewModel = viewModel
        super.init(frame: .zero, style: style)
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        backgroundColor = .white
        registerCells()
        setDefaultDelegates()
        configureTable()
    }

    func configureTable() {}

    func registerCells() {
        sections.forEach { section in
            section.cellsData.forEach { cellData in
                register(cellData.type, forCellReuseIdentifier: cellData.type.identifier)
            }
        }
    }

    func setDefaultDelegates() {
        dataSource = self
        delegate = self
    }

    func isLastCellInSection(for indexPath: IndexPath) -> Bool {
        let indexOfLastRowInSection = numberOfRows(inSection: indexPath.section) - 1
        return indexOfLastRowInSection == indexPath.row
    }
}

extension TableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].cellsData.count
    }

    func numberOfSections(in _: UITableView) -> Int {
        sections.count
    }

    func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section]
        guard !section.cellsData.isEmpty else { return nil }
        return section.title
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = sections[indexPath.section].cellsData[indexPath.row]
        let cellType = cellData.type
        let cellVM = cellData.viewModel

        guard let cell = dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? Cell
        else { return UITableViewCell() }
        cell.viewModel = cellVM
        cell.delegate = self

        let subscriber = cell.publisher
            .debounce(for: .seconds(eventDebounceValue), scheduler: RunLoop.main)
            .sink { event in
                self.viewModel.handle(event)
            }

        viewModel.addSubscriber(newSub: subscriber, with: cellType.identifier)

        if isLastCellInSection(for: indexPath) {
            cell.separatorLine.isHidden = true
        }

        return cell
    }
}

extension TableView: CellDelegate {
    func onUpdate() {
        // Used for UITextView auto height
        DispatchQueue.main.async {
            self.performBatchUpdates(nil)
        }
    }
}
