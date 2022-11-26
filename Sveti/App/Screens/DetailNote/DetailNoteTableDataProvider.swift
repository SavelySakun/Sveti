import Foundation

class DetailNoteTableDataProvider: TableDataProvider {
    override func configureSections(with data: Any? = nil) -> [TableSection] {
        guard let note = NotesRepository().getNote(with: data as? Int ?? 0) else { return [] }

        var tableSections = [
            TableSection(title: "Mark".localized, cellsData: [
                CellData(type: MoodScoreCell.self, viewModel: CellVM(cellValue: note)),
            ]),
        ]

        if !note.comment.isEmpty {
            tableSections.append(
                TableSection(title: "Comment".localized, cellsData: [
                    CellData(type: DetailNoteCommentCell.self, viewModel: CellVM(cellValue: note)),
                ])
            )
        }

        if !note.tags.isEmpty {
            tableSections.append(
                TableSection(title: "Tags".localized, cellsData: [
                    CellData(type: DetailTagsCell.self, viewModel: CellVM(cellValue: note)),
                ])
            )
        }

        return tableSections
    }
}
