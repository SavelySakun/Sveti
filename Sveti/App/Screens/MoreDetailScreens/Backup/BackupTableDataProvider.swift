import Foundation

class BackupTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {
    let cellType = SimpleCell.self
    let tableSections = [
      TableSection(title: "", cellsData: [
        CellData(type: cellType, viewModel: CellVM(cellValue: BackupToCloudCellItem())),
        CellData(type: cellType, viewModel: CellVM(cellValue: RestoreFromCloudCellItem()))
      ])
    ]
    return tableSections
  }

}
