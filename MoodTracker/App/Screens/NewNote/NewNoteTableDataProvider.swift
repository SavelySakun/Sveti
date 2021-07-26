import Foundation

class NewNoteTableDataProvider: TableDataProvider {

  override func configureSections() -> [TableSection] {

    let tableSections = [

      TableSection(title: "Дата", cellsData: [
        CellData(type: DatePickerCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: nil))
      ]),

      TableSection(title: "Самочувствие", cellsData: [
        CellData(type: MoodSliderCell.self, viewModel: CellVM(title: "Желание жить, делать дела")),
        CellData(type: PhysSliderCell.self, viewModel: CellVM(title: "Физическое самочувствие")),
      ]),

      TableSection(title: "Комментарий", cellsData: [
        CellData(type: CommentCell.self, viewModel: CellVM(title: "Комментарий"))
      ]),

    ]

    return tableSections
  }

}
