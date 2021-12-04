import Foundation

class EditTagGroupsTableDataProvider: TableDataProvider {


  override func configureSections(with data: Any? = nil) -> [TableSection] {

    let tableSections = [
      TableSection(title: "Groups", cellsData: getCellsData())
    ]
    return tableSections
  }

  private func getCellsData() -> [CellData] {
    let tagGroups = TagsRepository().groups
    var cellsData = [CellData]()

    tagGroups.forEach { group in
      let cellData = CellData(type: EditTagGroupsCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: group))
      cellsData.append(cellData)
    }

    return cellsData
  }
}
