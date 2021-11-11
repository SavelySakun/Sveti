import UIKit
import Combine

protocol CellDelegate: AnyObject {
  func onUpdate()
}

class Cell: UITableViewCell {

  var publisher = PassthroughSubject<Event, Never>()
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

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Calls on every cell reuse cycle. Its useful to update content here when reloading tableView.
  func configureSelf(with viewModel: CellVM) {
    selectionStyle = .none
  }

  /// Calls once when cell initialized.
  func setLayout() {
    // Do any customization here.
  }

}
