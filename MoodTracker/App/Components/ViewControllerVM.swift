import Foundation
import Combine

class ViewControllerVM {

  var subscribers = [AnyCancellable]()
  var tableDataProvider: TableDataProvider?

  init(tableDataProvider: TableDataProvider? = nil) {
    self.tableDataProvider = tableDataProvider
  }

  func handle<T: Event>(_ event: T) { }

}
