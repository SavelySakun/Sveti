import Foundation

class NewNoteTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {
    let tableSections = [

      TableSection(title: "Дата", cellsData: [
        CellData(type: DatePickerCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: nil))
      ]),

      TableSection(title: "Самочувствие", cellsData: [
        CellData(type: PhysicalStateSliderCell.self, viewModel: CellVM(title: "Физическое состояние")),
        CellData(type: EmotionalStateSliderCell.self, viewModel: CellVM(title: "Эмоциональное состояние"))
      ]),

      TableSection(title: "Комментарий", cellsData: [
        CellData(type: CommentCell.self, viewModel: CellVM(title: "Комментарий"))
      ]),

      TableSection(title: "Теги", cellsData: [
        CellData(type: TagCell.self, viewModel: CellVM())
      ])

    ]

    return tableSections
  }
}
