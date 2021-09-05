import Foundation
import Combine

protocol ViewControllerVMDelegate: AnyObject {
  func onNeedToUpdateContent()
}

class ViewControllerVM {

  var observingCellsWithIds = [String]()
  var subscribers = [AnyCancellable]()
  var tableDataProvider: TableDataProvider?
  weak var delegate: ViewControllerVMDelegate?
  var hasChanges = false

  init(tableDataProvider: TableDataProvider? = nil) {
    self.tableDataProvider = tableDataProvider
  }

  func addSubscriber(newSub: AnyCancellable, with cellIdentifier: String) {
    guard !observingCellsWithIds.contains(cellIdentifier) else { return }
    subscribers.append(newSub)
    observingCellsWithIds.append(cellIdentifier)
  }

  func handle<T: Event>(_ event: T) { }

}
