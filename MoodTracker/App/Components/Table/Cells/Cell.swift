import UIKit
import Combine

protocol CellDelegate: AnyObject {
  func onUpdate()
}

class Cell: UITableViewCell {

  var publisher = PassthroughSubject<EditEvent, Never>()
  weak var delegate: CellDelegate?

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
