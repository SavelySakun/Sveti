import UIKit

class EditTagGroupTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {

    let tableSections = [
      TableSection(title: "Название группы", cellsData: [
         CellData(type: TagGroupNameCell.self, viewModel: CellVM(cellValue: data))
      ]),

      TableSection(title: "Активно", cellsData: []),

      TableSection(title: "Скрыто", cellsData: [])
    ]
    return tableSections
  }

}
