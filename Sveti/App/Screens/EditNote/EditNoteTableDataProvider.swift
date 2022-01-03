import Foundation

class EditNoteTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {

    let tableSections = [
      TableSection(title: "Date".localized, cellsData: [
        CellData(type: DatePickerCell.self, viewModel: CellVM(cellValue: data))
      ]),

      TableSection(title: "Tags".localized, cellsData: [
        CellData(type: TagCell.self, viewModel: CellVM(title: nil, cellValue: data))
      ]),

      TableSection(title: "Mood".localized, cellsData: [
        CellData(type: PhysicalStateSliderCell.self, viewModel: CellVM(title: "Physical".localized, cellValue: data)),
        CellData(type: EmotionalStateSliderCell.self, viewModel: CellVM(title: "Emotional".localized, cellValue: data))
      ]),

      TableSection(title: "Comment".localized, cellsData: [
        CellData(type: CommentCell.self, viewModel: CellVM(cellValue: data))
      ])
    ]

    return tableSections
  }
}
