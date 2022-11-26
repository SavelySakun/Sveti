import Combine
import Foundation

protocol ViewControllerVMDelegate: AnyObject {
    func reloadContent()
}

class ViewControllerVM {
    var observingCellsWithIds = [String]()
    var subscribers = [AnyCancellable]()
    var tableDataProvider: TableDataProvider?
    weak var contentUpdateDelegate: ViewControllerVMDelegate?
    weak var informationDelegate: InformationDelegate?
    var hasChanges = false

    init(tableDataProvider: TableDataProvider? = nil) {
        self.tableDataProvider = tableDataProvider
    }

    func addSubscriber(newSub: AnyCancellable, with cellIdentifier: String) {
        guard !observingCellsWithIds.contains(cellIdentifier) else { return }
        subscribers.append(newSub)
        observingCellsWithIds.append(cellIdentifier)
    }

    func handle<T: Event>(_: T) {}
}
