import UIKit

class EditTagGroupsVC: VCwithTable {

  let newTagAlert = UIAlertController(title: "Add new group", message: "Specify the name of the group", preferredStyle: .alert)
  let addNewAction = UIAlertAction(title: "Add", style: .default)

  override init(with tableStyle: UITableView.Style = .insetGrouped) {
    super.init(with: tableStyle)
    tableView = EditTagGroupsTable(viewModel: viewModel)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    SvetiAnalytics.logMainEvent(.EditTagGroups)
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
    setNewGroupAlert()
  }

  override func getDataProvider() -> TableDataProvider? {
    return EditTagGroupsTableDataProvider()
  }

  override func updateContent() {
    DispatchQueue.main.async { [self] in
      UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve) {
        self.viewModel.tableDataProvider = self.getDataProvider()
        self.tableView.reloadData()
      }
    }
  }

  private func setNewGroupAlert() {
    newTagAlert.addTextField { textField in
      textField.placeholder = "Group name"
      textField.addTarget(self, action: #selector(self.textFieldDidChange), for: .allEditingEvents)
      textField.delegate = self
    }

    let dismissAction = UIAlertAction(title: "Cancel", style: .destructive)
    [addNewAction, dismissAction].forEach { action in
      newTagAlert.addAction(action)
    }
  }

  private func setNewGroupButton() {
    let button = UIButton()
    button.snp.makeConstraints { (make) in
      make.height.width.equalTo(30)
    }
    let image = UIImage(named: "addGroup")?.withRenderingMode(.alwaysTemplate)
    button.setTitleColor(.red, for: .selected)
    button.setImage(image, for: .normal)
    button.addTarget(self, action: #selector(onNewGroup), for: .touchUpInside)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
  }

  @objc private func onNewGroup() {
    present(newTagAlert, animated: true, completion: nil)
  }

  @objc private func textFieldDidChange() {
    addNewAction.isEnabled = !(newTagAlert.textFields?.last?.text?.isEmpty ?? true)
  }
}

extension EditTagGroupsVC: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let newGroupName = textField.text, !newGroupName.isEmpty else {
      return
    }
    addNewAction.isEnabled = true
    let newGroupId = UUID().uuidString
    TagsRepository().addNewGroup(withName: newGroupName, id: newGroupId)
    SvetiAnalytics.logMainEvent(.addTagGroup)
    let editTagGroupVC = EditTagGroupVC(groupId: newGroupId)
    editTagGroupVC.onClosingCompletion = {
      self.updateContent()
    }
    navigationController?.pushViewController(editTagGroupVC, animated: true)
    newTagAlert.textFields?.last?.text = ""
  }
}
