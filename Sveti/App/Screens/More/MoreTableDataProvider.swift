import Foundation

class MoreTableDataProvider: TableDataProvider {
    override func configureSections(with _: Any? = nil) -> [TableSection] {
        let cellType = SimpleCell.self
        let tableSections = [
            TableSection(title: "Features".localized, cellsData: [
                CellData(type: cellType, viewModel: CellVM(cellValue: EditTagGroupsMoreItem())),
                CellData(type: cellType, viewModel: CellVM(cellValue: BackupMoreItem())),
            ]),
            TableSection(title: "Other".localized, cellsData: [
                CellData(type: cellType, viewModel: CellVM(cellValue: ContactDeveloperMoreItem())),
                CellData(type: cellType, viewModel: CellVM(cellValue: AboutMoreItem())),
            ]),
        ]
        return tableSections
    }
}
