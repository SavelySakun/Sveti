import UIKit

class SimpleTableView: TableView {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? SimpleCell else { return }

        selectedCell.onTapAction?(selectedCell.publisher)
    }
}
