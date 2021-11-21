import UIKit

class MoreTableView: TableView {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let moreCell = tableView.cellForRow(at: indexPath) as? MoreCell else { return }
    moreCell.onTapAction?()
  }

}
