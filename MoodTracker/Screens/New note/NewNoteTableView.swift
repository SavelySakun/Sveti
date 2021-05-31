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
		3
	}

	override func numberOfRows(inSection section: Int) -> Int {
		10
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			guard let cell = dequeueReusableCell(withIdentifier: MoodCell.reuseId, for: indexPath) as? MoodCell else { return .init() }
			cell.setContent()
			return cell
		} else if indexPath.row == 1 {
			guard let cell = dequeueReusableCell(withIdentifier: CommentCell.reuseId, for: indexPath) as? CommentCell else { return .init() }
			return cell
		} else if indexPath.row == 2 {
			guard let cell = dequeueReusableCell(withIdentifier: HashtagCell.reuseId, for: indexPath) as? HashtagCell else { return .init() }
			return cell
		}
		return .init()
	}
}
