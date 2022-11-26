import UIKit

protocol SelectGroupTableViewDelegate: AnyObject {
    func onSelectGroup(with id: String)
}

class SelectGroupTableView: TableView {
    weak var groupSelectDelegate: SelectGroupTableViewDelegate?

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellValue = viewModel
            .tableDataProvider?
            .sections?[indexPath.section]
            .cellsData[indexPath.row]
            .viewModel
            .cellValue

        guard let selectGroupCellData = cellValue as? SelectGroupCellData else { return }
        groupSelectDelegate?.onSelectGroup(with: selectGroupCellData.groupId)
    }
}
