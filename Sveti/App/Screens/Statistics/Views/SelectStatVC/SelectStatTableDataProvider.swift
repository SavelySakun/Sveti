import Foundation
import RealmSwift

class SelectStatTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {
    let tableSections = [
      TableSection(title: "Select type".localized, cellsData: [
        CellData(type: SelectsStatCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: StatTypes.averageEmotional)),
        CellData(type: SelectsStatCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: StatTypes.averagePhysical)),
        CellData(type: SelectsStatCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: StatTypes.averageEmotionalAndPhysical))
      ])
    ]
    return tableSections
  }
}
