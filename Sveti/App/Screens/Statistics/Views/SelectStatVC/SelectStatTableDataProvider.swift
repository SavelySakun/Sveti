import Foundation
import RealmSwift

class SelectStatTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {
    let cellType = SelectsStatCell.self
    let tableSections = [
      TableSection(title: "Select type".localized, cellsData: [
        CellData(type: cellType, viewModel: CellVM(cellValue: StatTypes.averageEmotional)),
        CellData(type: cellType, viewModel: CellVM(cellValue: StatTypes.averagePhysical)),
        CellData(type: cellType, viewModel: CellVM(cellValue: StatTypes.averageEmotionalAndPhysical))
      ])
    ]
    return tableSections
  }
}
