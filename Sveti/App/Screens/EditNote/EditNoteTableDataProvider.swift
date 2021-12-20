import Foundation

class EditNoteTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {

    let tableSections = [

      TableSection(title: "Date", cellsData: [
        CellData(type: DatePickerCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: data))
      ]),

      TableSection(title: "Tags", cellsData: [
        CellData(type: TagCell.self, viewModel: CellVM(title: nil, cellValue: data))
      ]),

      TableSection(title: "Mood", cellsData: [
        CellData(type: PhysicalStateSliderCell.self, viewModel: CellVM(title: "Physical", cellValue: data)),
        CellData(type: EmotionalStateSliderCell.self, viewModel: CellVM(title: "Emotional", cellValue: data))
      ]),

      TableSection(title: "Комментарий", cellsData: [
        CellData(type: CommentCell.self, viewModel: CellVM(title: "Комментарий", cellValue: data))
      ])
    ]

    return tableSections
  }
}
