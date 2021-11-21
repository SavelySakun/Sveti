import Foundation

class NewNoteTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {
    let tableSections = [

      TableSection(title: "Date", cellsData: [
        CellData(type: DatePickerCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: nil))
      ]),

      TableSection(title: "Tags", cellsData: [
        CellData(type: TagCell.self, viewModel: CellVM())
      ]),

      TableSection(title: "Mood", cellsData: [
        CellData(type: PhysicalStateSliderCell.self, viewModel: CellVM(title: "Physical")),
        CellData(type: EmotionalStateSliderCell.self, viewModel: CellVM(title: "Emotional"))
      ]),

      TableSection(title: "Comment", cellsData: [
        CellData(type: CommentCell.self, viewModel: CellVM(title: ""))
      ]),



    ]

    return tableSections
  }
}
