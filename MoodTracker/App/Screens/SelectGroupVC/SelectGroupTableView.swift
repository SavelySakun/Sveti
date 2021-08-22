import UIKit

protocol SelectGroupTableViewDelegate: AnyObject {
  func onSelectGroup(in section: Int)
}

class SelectGroupTableView: TableView {
  weak var groupSelectDelegate: SelectGroupTableViewDelegate?

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    groupSelectDelegate?.onSelectGroup(in: indexPath.row)
  }
}
