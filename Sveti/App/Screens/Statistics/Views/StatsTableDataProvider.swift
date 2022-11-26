import Foundation

class StatsTableDataProvider: TableDataProvider {
    override func configureSections(with data: Any? = nil) -> [TableSection] {
        let tableSections = [
            TableSection(title: "Statistics".localized, cellsData: [
                CellData(type: BarChartCell.self, viewModel: CellVM(title: nil, subtitle: nil, cellValue: data)),
            ]),
            TableSection(title: "Detail analysis".localized, cellsData: [
                CellData(type: DetailStatCell.self, viewModel: DetailStatCellVM()),
            ]),
        ]
        return tableSections
    }
}
