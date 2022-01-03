import UIKit

class EditTagGroupTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {
    let tableSections = [
      TableSection(title: "Group name".localized, cellsData: [
         CellData(type: TagGroupNameCell.self, viewModel: CellVM(cellValue: data))
      ]),
      TableSection(title: "Active".localized, cellsData: []),
      TableSection(title: "Hidden".localized, cellsData: [])
    ]
    return tableSections
  }

}
