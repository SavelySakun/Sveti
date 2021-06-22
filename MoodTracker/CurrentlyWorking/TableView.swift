import UIKit

class TableView: UITableView {

	let sections: [TableSection]

  init(sections: [TableSection]) {
		self.sections = sections
		super.init(frame: .zero, style: .insetGrouped)
		setLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setLayout() {
    registerCells()
    setDefaultDelegates()
    configureTable()
	}

	private func configureTable() { }

  private func registerCells() {
    sections.forEach { section in
      section.cellsData.forEach { cellData in
        register(cellData.type, forCellReuseIdentifier: cellData.type.identifier )
      }
    }
  }

  private func setDefaultDelegates() {
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
		sections[section].title
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cellData = sections[indexPath.section].cellsData[indexPath.row]
    let cellType = cellData.type
    let cellVM = cellData.viewModel

    guard let cell = dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? Cell
    else { return UITableViewCell() }
    cell.viewModel = cellVM

    return cell
	}

}
