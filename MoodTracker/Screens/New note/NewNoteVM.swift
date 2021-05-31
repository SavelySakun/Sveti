import UIKit

struct TableSection {
	let title: String?
	let cells: [UITableViewCell]
}

class NewNoteVM {

	let tableItems: [TableSection] = [
		TableSection(title: "Самочувствие", cells: [MoodCell(), MoodCell(), MoodCell()]),
		TableSection(title: "Комментарий", cells: [CommentCell()]),
		TableSection(title: "Хэштеги", cells: [HashtagCell()])
	]
	
}


