import Foundation

class DetailNoteTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {

    var tableSections = [
      TableSection(title: "Mark", cellsData: [
        CellData(type: MoodScoreCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: data))
      ])
    ]

    guard let note = data as? Note else { return tableSections }

    if !note.comment.isEmpty {
      tableSections.append(
        TableSection(title: "Comment", cellsData: [
          CellData(type: DetailNoteCommentCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: data))
        ])
      )
    }

    if !note.tags.isEmpty {
      tableSections.append(
        TableSection(title: "Tags", cellsData: [
          CellData(type: DetailTagsCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: data))
        ])
      )
    }

    return tableSections
  }

}
