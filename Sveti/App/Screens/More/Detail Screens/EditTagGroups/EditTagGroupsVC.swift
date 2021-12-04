import UIKit
import SPAlert

class EditTagGroupsVC: VCwithTable {

  override init(with tableStyle: UITableView.Style = .insetGrouped) {
    super.init(with: tableStyle)
    tableView = EditTagGroupsTable(viewModel: viewModel)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    updateContent()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func setLayout() {
    super.setLayout()
    title = "Tag groups"
    tableView.backgroundColor = .systemGray6
    tableView.allowsSelectionDuringEditing = true
    tableView.isEditing = true
    setNewGroupButton()
  }

  override func getDataProvider() -> TableDataProvider? {
    return EditTagGroupsTableDataProvider()
  }

  override func updateContent() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }

  private func setNewGroupButton() {
    let button = UIButton()
    button.snp.makeConstraints { (make) in
      make.height.width.equalTo(26)
    }
    let image = UIImage(named: "addGroup")?.withRenderingMode(.alwaysTemplate)
    button.setTitleColor(.red, for: .selected)
    button.setImage(image, for: .normal)
    button.addTarget(self, action: #selector(onNewGroup), for: .touchUpInside)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
  }

  @objc private func onNewGroup() {
    let newTagAlert = UIAlertController(title: "Add new group", message: "Specify the name of the group", preferredStyle: .alert)
    newTagAlert.addTextField { textField in
      textField.placeholder = "Group name"
      textField.delegate = self
    }
    let addNewAction = UIAlertAction(title: "Add", style: .default)
    let dismissAction = UIAlertAction(title: "Cancel", style: .destructive)
    [addNewAction, dismissAction].forEach { action in
      newTagAlert.addAction(action)
    }
    present(newTagAlert, animated: true, completion: nil)
  }
}

extension EditTagGroupsVC: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let newGroupName = textField.text else {
      SPAlert.present(message: "You must specify the name of the group", haptic: .error)
      return
    }
    let newGroupId = UUID().uuidString
    TagsRepository().addNewGroup(with: newGroupName, id: newGroupId)
    navigationController?.pushViewController(EditTagGroupVC(groupId: newGroupId), animated: true)
  }
}
