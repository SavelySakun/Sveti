import UIKit

class EditingTableView: TableView {
  var groupId = String()

  override func registerCells() {
    super.registerCells()
    register(TagGroupCell.self, forCellReuseIdentifier: TagGroupCell.identifier)
    register(NoTagFound.self, forCellReuseIdentifier: NoTagFound.identifier)
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let cellsCount = sections[section].cellsData.count
    return (cellsCount == 0 && section == 1) ? 1 : cellsCount
  }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let tableSection = sections[section]
    if section == 1 {
      return tableSection.title
    } else if tableSection.cellsData.isEmpty {
      return nil
    } else {
      return tableSection.title
    }
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if sections[indexPath.section].cellsData.isEmpty {
      let cell = dequeueReusableCell(withIdentifier: NoTagFound.identifier, for: indexPath) as? Cell
      return cell ?? UITableViewCell()
    } else {
      return super.tableView(tableView, cellForRowAt: indexPath)
    }
  }

  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    guard !sections[indexPath.section].cellsData.isEmpty else { return false }
    return indexPath.section == 1
  }

  func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
    if sourceIndexPath.section < proposedDestinationIndexPath.section {
      return IndexPath(row: (tableView.numberOfRows(inSection: sourceIndexPath.section) - 1), section: sourceIndexPath.section)
    } else if sourceIndexPath.section > proposedDestinationIndexPath.section {
      return IndexPath(row: 0, section: sourceIndexPath.section)
    } else {
      return proposedDestinationIndexPath
    }
  }

  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    TagsRepository().reorder(moveRowAt: sourceIndexPath, to: destinationIndexPath, groupId: groupId)
  }

  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    .none
  }

  func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
    false
  }
}
