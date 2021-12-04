import UIKit

class EditTagGroupsTable: TableView {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    guard let currentVC = CurrentVC.current as? EditTagGroupsVC else { return }

    guard let cellValue = viewModel
      .tableDataProvider?
      .sections?[indexPath.section]
      .cellsData[indexPath.row]
      .viewModel
      .cellValue as? TagGroup else { return }

    let editTagGroupVC = EditTagGroupVC(groupId: cellValue.id)

    currentVC.navigationController?.pushViewController(editTagGroupVC, animated: true)
  }

  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    true
  }

  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    .none
  }

  func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
    false
  }

  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    //
  }
}
