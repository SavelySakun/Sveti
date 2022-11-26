import Foundation

class EditTagGroupsTableDataProvider: TableDataProvider {
    override func configureSections(with _: Any? = nil) -> [TableSection] {
        return [TableSection(title: "Groups".localized, cellsData: getCellsData())]
    }

    private func getCellsData() -> [CellData] {
        let tagGroups = TagsRepository().groups
        var cellsData = [CellData]()

        tagGroups.forEach { group in
            let cellData = CellData(type: EditTagGroupsCell.self, viewModel: CellVM(cellValue: group))
            cellsData.append(cellData)
        }

        return cellsData
    }
}
