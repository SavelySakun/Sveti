import Foundation

class MoreTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {

    let tableSections = [

      TableSection(title: "Other", cellsData: [
        CellData(type: MoreCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: ContactDeveloperMoreItem()))
      ])
    ]
    return tableSections
  }

}
