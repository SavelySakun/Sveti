import Foundation

class StatsTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {
    let tableSections = [
      TableSection(title: "Statistics", cellsData: [
        CellData(type: BarChartCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: data))
      ])
    ]
    return tableSections
  }
  
}
