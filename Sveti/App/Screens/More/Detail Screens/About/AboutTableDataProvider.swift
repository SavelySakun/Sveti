import Foundation

class AboutTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {
    let tableSections = [
      TableSection(title: "", cellsData: [
        CellData(type: SimpleCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: AppInfoModel())),
        CellData(type: SimpleCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: Icon8Model()))
      ])
    ]
    return tableSections
  }

}
