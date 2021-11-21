import Foundation

class MoreTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {

    let tableSections = [
      TableSection(title: "Features", cellsData: [
        CellData(type: MoreCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: EditTagGroupsMoreItem())),
        CellData(type: MoreCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: DownloadDataMoreItem()))
      ]),
      TableSection(title: "Other", cellsData: [
        CellData(type: MoreCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: ContactDeveloperMoreItem())),
        CellData(type: MoreCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: AboutMoreItem()))
      ])
    ]
    return tableSections
  }

}
