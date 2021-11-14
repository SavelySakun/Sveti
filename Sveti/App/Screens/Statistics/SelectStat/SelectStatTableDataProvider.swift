import Foundation
import RealmSwift



class SelectStatTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {
    let tableSections = [
      TableSection(title: "Select type", cellsData: [
        CellData(type: SelectsStatCell.self, viewModel: CellVM(title: StatTypes.averageEmotional.getStatTypeDescription(), subtitle: nil, cellValue: data)),
        CellData(type: SelectsStatCell.self, viewModel: CellVM(title: StatTypes.averagePhysical.getStatTypeDescription(), subtitle: nil, cellValue: data)),
        CellData(type: SelectsStatCell.self, viewModel: CellVM(title: StatTypes.averageEmotionalAndPhysical.getStatTypeDescription(), subtitle: nil, cellValue: data))
      ])
    ]
    return tableSections
  }
}
