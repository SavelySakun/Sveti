import Foundation
import Combine

class ViewControllerVM {

  var subs = [AnyCancellable]()
  var tableDataProvider: TableDataProvider?

  init(tableDataProvider: TableDataProvider? = nil) {
    self.tableDataProvider = tableDataProvider
  }

  func handle(_ event: EditEvent) { }

}





