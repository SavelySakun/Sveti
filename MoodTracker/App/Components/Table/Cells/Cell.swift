import UIKit
import Combine

class Cell: UITableViewCell {

  var publisher = PassthroughSubject<EditEvent, Never>()

  var viewModel: CellVM? {
    didSet {
      guard let viewModel = viewModel else { return }
      configureSelf(with: viewModel)
    }
  }
  
  static var identifier: String {
    return NSStringFromClass(self)
  }

  func configureSelf(with viewModel: CellVM) {
    selectionStyle = .none
  }

}
