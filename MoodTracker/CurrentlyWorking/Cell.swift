import UIKit

class Cell: UITableViewCell {

  var viewModel: CellVM? {
    didSet {
      guard let viewModel = viewModel else { return }
      configureSelf(with: viewModel)
    }
  }
  
  static var identifier: String {
    return NSStringFromClass(self)
  }

  func configureSelf(with viewModel: CellVM) { }

}
