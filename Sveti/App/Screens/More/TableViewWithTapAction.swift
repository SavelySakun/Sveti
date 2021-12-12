import UIKit

class TableViewWithTapAction: TableView {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let selectedCell = tableView.cellForRow(at: indexPath) as? ICellWithOnTapAction else { return }
    selectedCell.onTapAction?()
  }

}
