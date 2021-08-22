import Foundation

class SelectGroupTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {
    let tableSections = [
      TableSection(title: "Выберите группу", cellsData: getDataForCells()),
    ]
    return tableSections
  }

  private func getDataForCells() -> [CellData] {
    var cellsData = [CellData]()
    let groups = TagsRepository().groups

    groups.forEach { group in
      cellsData.append(CellData(type: SelectGroupCell.self, viewModel: CellVM(title: group.title)))
    }

    return cellsData
  }
}

