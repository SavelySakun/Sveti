import Foundation

class SelectGroupTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {
    let tableSections = [
      TableSection(title: "Выберите группу", cellsData: [
         CellData(type: SelectGroupCell.self, viewModel: CellVM(cellValue: data)),
        CellData(type: SelectGroupCell.self, viewModel: CellVM(cellValue: data)),
        CellData(type: SelectGroupCell.self, viewModel: CellVM(cellValue: data)),
        CellData(type: SelectGroupCell.self, viewModel: CellVM(cellValue: data)),
        CellData(type: SelectGroupCell.self, viewModel: CellVM(cellValue: data)),
        CellData(type: SelectGroupCell.self, viewModel: CellVM(cellValue: data)),
        CellData(type: SelectGroupCell.self, viewModel: CellVM(cellValue: data)),
        CellData(type: SelectGroupCell.self, viewModel: CellVM(cellValue: data))
      ]),
    ]
    return tableSections
  }



}

