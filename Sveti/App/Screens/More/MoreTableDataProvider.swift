import Foundation

class MoreTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {

    let tableSections = [
      TableSection(title: "Features", cellsData: [
        CellData(type: SimpleCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: EditTagGroupsMoreItem()))
      ]),
      TableSection(title: "Other", cellsData: [
        CellData(type: SimpleCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: ContactDeveloperMoreItem())),
        CellData(type: SimpleCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: AboutMoreItem()))
      ])
    ]
    return tableSections
  }

}
