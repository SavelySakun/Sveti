import Foundation

class EditNoteTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {

    let tableSections = [

      TableSection(title: "Дата", cellsData: [
        CellData(type: DatePickerCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: data))
      ]),

      TableSection(title: "Самочувствие", cellsData: [
        CellData(type: EmotionalStateSliderCell.self, viewModel: CellVM(title: "Эмоциональное состояние", cellValue: data)),
        CellData(type: PhysicalStateSliderCell.self, viewModel: CellVM(title: "Физическое состояние", cellValue: data)),
        CellData(type: WillToLiveStateSliderCell.self, viewModel: CellVM(title: "Желание жить, делать дела", cellValue: data))
      ]),

      TableSection(title: "Комментарий", cellsData: [
        CellData(type: CommentCell.self, viewModel: CellVM(title: "Комментарий", cellValue: data))
      ]),

      TableSection(title: "Тэги", cellsData: [
        CellData(type: TagCell.self, viewModel: CellVM(title: nil, cellValue: data))
      ])
    ]

    return tableSections
  }
}
