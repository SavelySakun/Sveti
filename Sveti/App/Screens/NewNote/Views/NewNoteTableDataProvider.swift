import Foundation

class NewNoteTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {
    let tableSections = [

      TableSection(title: "Date".localized, cellsData: [
        CellData(type: DatePickerCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: nil))
      ]),

      TableSection(title: "Tags".localized, cellsData: [
        CellData(type: TagCell.self, viewModel: CellVM())
      ]),

      TableSection(title: "Mood".localized, cellsData: [
        CellData(type: PhysicalStateSliderCell.self, viewModel: CellVM(title: "Physical".localized)),
        CellData(type: EmotionalStateSliderCell.self, viewModel: CellVM(title: "Emotional".localized))
      ]),

      TableSection(title: "Comment".localized, cellsData: [
        CellData(type: CommentCell.self, viewModel: CellVM(title: ""))
      ]),



    ]

    return tableSections
  }
}
