import Foundation
import Combine

protocol ViewControllerVMDelegate: AnyObject {
  func onNeedToUpdateContent()
}

class ViewControllerVM {

  var subscribers = [AnyCancellable]()
  var tableDataProvider: TableDataProvider?
  weak var delegate: ViewControllerVMDelegate?

  init(tableDataProvider: TableDataProvider? = nil) {
    self.tableDataProvider = tableDataProvider
  }

  func handle<T: Event>(_ event: T) { }

}
