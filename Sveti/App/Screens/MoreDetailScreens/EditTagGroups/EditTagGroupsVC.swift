import UIKit

class EditTagGroupsVC: VCwithTable {

  private let emptyView = ImageTextView(imageName: "noContent", text: "No groups found".localized)
  private let newGroupAlert = UIAlertController(title: "Add new group".localized, message: "Specify the name of the group".localized, preferredStyle: .alert)
  private var addNewAction: UIAlertAction?
  private var alertTextField: UITextField? {
    newGroupAlert.textFields?.last
  }

  override init(with tableStyle: UITableView.Style = .insetGrouped) {
    super.init(with: tableStyle)
    tableView = EditTagGroupsTable(viewModel: viewModel)
    addNewAction = UIAlertAction(title: "Add".localized, style: .default) { _ in
      self.saveNewGroup()
    }
  }

  override func logOpenScreenEvent() {
    SvetiAnalytics.log(.EditTagGroups)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func setLayout() {
    super.setLayout()
    title = "Tag groups".localized
    tableView.register(EditTagGroupsCell.self, forCellReuseIdentifier: EditTagGroupsCell.identifier)
    tableView.backgroundColor = .systemGray6
    tableView.allowsSelectionDuringEditing = true
    tableView.isEditing = true
    setNewGroupButton()
    setNewGroupAlert()
    setNoGroupsTextImage()
  }

  override func getDataProvider() -> TableDataProvider? {
    return EditTagGroupsTableDataProvider()
  }

  override func updateContent() {
    DispatchQueue.main.async { [self] in
      UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve) {
        self.viewModel.tableDataProvider?.updateSections()
        self.updateEmptyViewVisibility()
        self.tableView.reloadData()
      }
    }
  }

  private func setNewGroupAlert() {
    newGroupAlert.addTextField { textField in
      textField.placeholder = "Group name".localized
      textField.addTarget(self, action: #selector(self.textFieldDidChange), for: .allEditingEvents)
    }

    let dismissAction = UIAlertAction(title: "Cancel".localized, style: .cancel) {_ in
      self.alertTextField?.text?.removeAll()
    }

    guard let addNewAction = self.addNewAction else { return }
    [addNewAction, dismissAction].forEach { action in
      newGroupAlert.addAction(action)
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
    present(newGroupAlert, animated: true, completion: nil)
  }

  @objc private func textFieldDidChange() {
    addNewAction?.isEnabled = !(newGroupAlert.textFields?.last?.text?.isEmpty ?? true)
  }

  @objc private func saveNewGroup() {
    guard let newGroupName = alertTextField?.text, !newGroupName.isEmpty else {
      return
    }
    addNewAction?.isEnabled = true
    let newGroupId = UUID().uuidString
    TagsRepository().addNewGroup(withName: newGroupName, id: newGroupId)
    SvetiAnalytics.log(.addTagGroup)
    let editTagGroupVC = EditTagGroupVC(groupId: newGroupId)
    editTagGroupVC.onClosingCompletion = {
      self.updateContent()
    }
    navigationController?.pushViewController(editTagGroupVC, animated: true)
    newGroupAlert.textFields?.last?.text?.removeAll()
  }

  private func setNoGroupsTextImage() {
    view.addSubview(emptyView)
    updateEmptyViewVisibility()
    emptyView.snp.makeConstraints { (make) in
      make.height.equalToSuperview().multipliedBy(0.35)
      make.width.equalToSuperview().multipliedBy(0.7)
      make.centerX.centerY.equalToSuperview()
    }
  }

  private func updateEmptyViewVisibility() {
    let lastSection = viewModel.tableDataProvider?.sections?.last
    let isHidden = !(lastSection?.cellsData.isEmpty ?? false)
    DispatchQueue.main.async {
      self.emptyView.isHidden = isHidden
    }
  }
}
