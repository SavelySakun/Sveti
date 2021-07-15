import Foundation

class NewNoteTableDataProvider: TableDataProvider {

  override func configureSections() -> [TableSection] {

    let tableSections = [

      TableSection(title: "Самочувствие", cellsData: [
        CellData(type: MoodSliderCell.self, viewModel: CellVM(title: "Желание жить, делать дела")),
        CellData(type: PhysSliderCell.self, viewModel: CellVM(title: "Физическое самочувствие")),
      ]),

    ]

    return tableSections
  }

}
