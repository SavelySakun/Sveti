import UIKit

class NewNoteTableView: UITableView {

	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		setLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setLayout() {
		configureDelegates()
	}

	private func configureDelegates() {
		register(MoodCell.self, forCellReuseIdentifier: MoodCell.reuseId)
		dataSource = self
		delegate = self
	}
}

extension NewNoteTableView: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		1
	}

	override func numberOfRows(inSection section: Int) -> Int {
		10
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = dequeueReusableCell(withIdentifier: MoodCell.reuseId, for: indexPath) as? MoodCell else { return .init() }
		cell.setContent()
		return cell
	}
}
