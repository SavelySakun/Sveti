import UIKit

class NewNoteTableView: UITableView {

	let items: [TableSection]

	init(items: [TableSection]) {
		self.items = items
		super.init(frame: .zero, style: .insetGrouped)
		setLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setLayout() {
		configureTable()
	}

	private func configureTable() {
		register(CommentCell.self, forCellReuseIdentifier: CommentCell.reuseId)
		register(MoodCell.self, forCellReuseIdentifier: MoodCell.reuseId)
		register(HashtagCell.self, forCellReuseIdentifier: HashtagCell.reuseId)
		dataSource = self
		delegate = self
	}
}

extension NewNoteTableView: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		items[section].cells.count
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		items.count
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		items[section].title
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return getConfiguredCell(indexPath)
	}

	internal func getConfiguredCell(_ indexPath: IndexPath) -> UITableViewCell {
		guard let cell = items[indexPath.section].cells[indexPath.row] as? TableViewCell else { return .init() }
		cell.configureWithData(at: indexPath.row)
		return cell
	}
	
}
