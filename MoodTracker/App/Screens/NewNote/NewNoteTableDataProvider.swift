import Foundation

class NewNoteTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {
    
    let tableSections = [

      TableSection(title: "Дата", cellsData: [
        CellData(type: DatePickerCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: nil))
      ]),

      TableSection(title: "Самочувствие", cellsData: [
        CellData(type: EmotionalStateSliderCell.self, viewModel: CellVM(title: "Эмоциональное состояние")),
        CellData(type: PhysicalStateSliderCell.self, viewModel: CellVM(title: "Физическое состояние")),
        CellData(type: WillToLiveStateSliderCell.self, viewModel: CellVM(title: "Желание жить, делать дела"))
      ]),

      TableSection(title: "Комментарий", cellsData: [
        CellData(type: CommentCell.self, viewModel: CellVM(title: "Комментарий"))
      ]),

    ]

    return tableSections
  }



}
