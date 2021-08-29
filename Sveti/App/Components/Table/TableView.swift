import UIKit
import Combine

class TableView: UITableView {

  let viewModel: ViewControllerVM
  var sections: [TableSection] {
    viewModel.tableDataProvider!.sections!
  }
  var eventDebounceValue = 0.4

  init(viewModel: ViewControllerVM, style: UITableView.Style = .insetGrouped) {
    self.viewModel = viewModel
		super.init(frame: .zero, style: style)
		setLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setLayout() {
    backgroundColor = .white
    registerCells()
    setDefaultDelegates()
    configureTable()
	}

	private func configureTable() { }

  func registerCells() {
    sections.forEach { section in
      section.cellsData.forEach { cellData in
        register(cellData.type, forCellReuseIdentifier: cellData.type.identifier )
      }
    }
  }

  func setDefaultDelegates() {
    dataSource = self
    delegate = self
  }
}

extension TableView: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    sections[section].cellsData.count
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		sections.count
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let section = sections[section]
    guard !section.cellsData.isEmpty else { return nil }
		return section.title
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

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

    return cell
	}

}

extension TableView: CellDelegate {
  func onUpdate() {
    // Использую для автовысоты UITextView
    self.beginUpdates()
    self.endUpdates()
  }
}
