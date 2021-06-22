import Foundation

class NewNoteTableDataProvider: TableDataProvider {

  override func configureSections() -> [TableSection] {

    let tableSections = [

      TableSection(title: "Самочувствие", cellsData: [
        CellData(type: CellWithSlider.self, viewModel: CellVM(title: "Желание жить, делать дела")),
        CellData(type: CellWithSlider.self, viewModel: CellVM(title: "Физическое самочувствие")),
      ]),

      TableSection(title: "Комментарий", cellsData: [
        CellData(type: CommentCell.self, viewModel: CellVM()),
      ])

    ]

    return tableSections
  }

}
