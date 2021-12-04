import UIKit

class EditTagGroupTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {

    let tableSections = [
      TableSection(title: "Group name", cellsData: [
         CellData(type: TagGroupNameCell.self, viewModel: CellVM(cellValue: data))
      ]),

      TableSection(title: "Active", cellsData: []),

      TableSection(title: "Hidden", cellsData: [])
    ]
    return tableSections
  }

}
