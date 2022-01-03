import Foundation

class AboutTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {
    let cellType = SimpleCell.self
    let tableSections = [
      TableSection(title: "", cellsData: [
        CellData(type: cellType, viewModel: CellVM(cellValue: LinkToSiteModel())),
        CellData(type: cellType, viewModel: CellVM(cellValue: AppInfoModel())),
        CellData(type: cellType, viewModel: CellVM(cellValue: Icon8Model()))
      ])
    ]
    return tableSections
  }

}
