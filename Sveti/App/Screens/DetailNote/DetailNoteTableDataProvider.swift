import Foundation

class DetailNoteTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {

    guard let note = NotesRepository().getNote(with: data as? Int ?? 0) else { return [] }

    var tableSections = [
      TableSection(title: "Mark", cellsData: [
        CellData(type: MoodScoreCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: note))
      ])
    ]

   // guard let note = data as? Note else { return tableSections }

    if !note.comment.isEmpty {
      tableSections.append(
        TableSection(title: "Comment", cellsData: [
          CellData(type: DetailNoteCommentCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: note))
        ])
      )
    }

    if !note.tags.isEmpty {
      tableSections.append(
        TableSection(title: "Tags", cellsData: [
          CellData(type: DetailTagsCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: note))
        ])
      )
    }

    return tableSections
  }

}
