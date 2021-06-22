import Foundation

class ViewControllerVM {

  var tableDataProvider: TableDataProvider?

  init(tableDataProvider: TableDataProvider? = nil) {
    self.tableDataProvider = tableDataProvider
  }

}
