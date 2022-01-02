import Foundation

struct SelectGroupCellData {
  let title: String
  let groupId: String
}

class SelectGroupTableDataProvider: TableDataProvider {
  var editingGroupId = String()

  override func configureSections(with data: Any? = nil) -> [TableSection] {
    guard let groupId = data as? String else { return [TableSection]() }
    editingGroupId = groupId
    
    let tableSections = [
      TableSection(title: "Select a group".localized, cellsData: getCellsData()),
    ]
    return tableSections
  }

  private func getCellsData() -> [CellData] {
    var cellsData = [CellData]()
    let groups = TagsRepository().groups

    groups.forEach { group in
      guard group.id != editingGroupId else { return }
      let cellValue = SelectGroupCellData(title: group.title, groupId: group.id)
      let cellVM = CellVM(cellValue: cellValue)
      cellsData.append(CellData(type: SelectGroupCell.self, viewModel: cellVM))
    }

    return cellsData
  }
}

