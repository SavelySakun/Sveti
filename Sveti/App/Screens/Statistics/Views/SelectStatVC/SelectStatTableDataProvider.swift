import Foundation
import RealmSwift

class SelectStatTableDataProvider: TableDataProvider {
    override func configureSections(with _: Any? = nil) -> [TableSection] {
        let cellType = SelectsStatCell.self
        let tableSections = [
            TableSection(title: "Select type".localized, cellsData: [
                CellData(type: cellType, viewModel: CellVM(cellValue: StatType.emotional)),
                CellData(type: cellType, viewModel: CellVM(cellValue: StatType.physical)),
                CellData(type: cellType, viewModel: CellVM(cellValue: StatType.all)),
            ]),
        ]
        return tableSections
    }
}
