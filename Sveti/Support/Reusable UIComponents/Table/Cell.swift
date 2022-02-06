import UIKit
import Combine

protocol CellDelegate: AnyObject {
  func onUpdate()
}

class Cell: UITableViewCell {

  var publisher = PassthroughSubject<Event, Never>()
  weak var delegate: CellDelegate?
  let separatorLine = UIView()

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

  /// Call this you need custom separator at the bottom. By default in TableView separator in the last cell in section hides (isLastCellInSection check).
  func setSeparatorLine() {
    separatorLine.backgroundColor = .systemGray5
    contentView.addSubview(separatorLine)
    separatorLine.snp.makeConstraints { (make) in
      make.left.equalToSuperview().offset(UIUtils.bigOffset)
      make.right.equalToSuperview()
      make.bottom.equalToSuperview()
      make.height.equalTo(1)
    }
  }
}
