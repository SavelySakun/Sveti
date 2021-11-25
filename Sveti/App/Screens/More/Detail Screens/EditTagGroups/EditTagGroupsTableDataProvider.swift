import Foundation

class EditTagGroupsTableDataProvider: TableDataProvider {


  override func configureSections(with data: Any? = nil) -> [TableSection] {

    let tableSections = [
      TableSection(title: "Groups", cellsData: [
        CellData(type: EditTagGroupsCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: nil)),
        CellData(type: EditTagGroupsCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: nil)),
        CellData(type: EditTagGroupsCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: nil))
      ])
    ]
    return tableSections
    
  }
}
