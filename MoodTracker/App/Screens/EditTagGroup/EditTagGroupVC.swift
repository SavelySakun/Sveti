import UIKit
import ALPopup
import SPAlert

class EditTagGroupVC: VCwithTable {

  private let actionsAlertController = UIAlertController()
  private let newTagAlertController = UIAlertController(title: "Добавить тег", message: nil, preferredStyle: .alert)
  private let deleteGroupAlertController = UIAlertController(title: "Внимание", message: "Удалить группу?", preferredStyle: .alert)

  let groupId: String
  private let tagsRepository = TagsRepository()
  var editingTagId = String() // Use for update tags in actionSheet called from TagGroupCell
  private var hideAction = UIAlertAction(title: "", style: .default)


  init(groupId: String) {
    self.groupId = groupId
    super.init(with: .insetGrouped)
    let editingTableView = EditingTableView(viewModel: viewModel, style: .grouped)
    editingTableView.groupId = groupId
    tableView = editingTableView
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    onClosingCompletion()
  }

  override func getDataProvider() -> TableDataProvider? {
    EditTagGroupTableDataProvider(with: groupId)
  }

  override func setViewModel(with dataProvider: TableDataProvider) {
    viewModel = EditTagGroupVM(tableDataProvider: dataProvider, tagGroupId: groupId)
    viewModel.delegate = self
  }

  override func setLayout() {
    super.setLayout()
    tableView.separatorColor = .clear
    tableView.isEditing = true
    tableView.eventDebounceValue = 0

    let footerView = EditTagGroupTableFooter(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
    footerView.onDeleteTapHandler = {
      self.present(self.deleteGroupAlertController, animated: true, completion: nil)
    }
    
    tableView.tableFooterView = footerView

    title = "Изменить"
    navigationItem.largeTitleDisplayMode = .never
    setActionsAlertController()
    setNewTagButton()
    setNewTagAlert()
    setActionsForDeleteAlertController()
  }

  private func setNewTagButton() {
    let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onNewTagTap))
    navigationItem.rightBarButtonItem = rightButton
  }

  private func setNewTagAlert() {
    newTagAlertController.addTextField { textField in
      textField.placeholder = "Название тега"
    }

    let addAction = UIAlertAction(title: "Добавить", style: .default) { _ in
      self.saveNewTag()
    }

    let dismissAction = UIAlertAction(title: "Отмена", style: .destructive) { _ in
      self.newTagAlertController.textFields?.last?.text?.removeAll()
    }

    [dismissAction, addAction].forEach { action in
      newTagAlertController.addAction(action)
    }
  }

  private func setActionsAlertController() {
    hideAction = UIAlertAction(title: "Скрыть", style: .default) { _ in
      self.tagsRepository.updateHidden(with: self.editingTagId)
      self.onNeedToUpdateContent()
    }

    let changeGroupAction = UIAlertAction(title: "Переместить", style: .default) { _ in
      let selectGroupVC = SelectGroupVC()
      var popupVC = ALCardController()

      selectGroupVC.moovingTagId = self.editingTagId
      selectGroupVC.markAsCurrentVC = false

      selectGroupVC.onSelectionCompletion = { groupTitle in
        popupVC.dismiss(animated: true)
        self.onNeedToUpdateContent()
        SPAlert.present(title: "Готово", message: "Тег перемещен в группу «\(groupTitle)»", preset: .done, haptic: .success)
      }

      popupVC = ALPopup.card(controller: selectGroupVC)
      popupVC.push(from: self)
    }

    let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
      guard let tag = self.tagsRepository.findTag(with: self.editingTagId) else { return }
      SPAlert.present(title: "Готово", message: "Тег «\(tag.name)» удалён", preset: .done, haptic: .success)
      self.tagsRepository.removeTag(with: self.editingTagId)
      self.onNeedToUpdateContent()
    }

    let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)

    [hideAction, changeGroupAction, deleteAction, cancelAction].forEach { action in
      actionsAlertController.addAction(action)
    }
  }

  func showEditAlert(forTag id: String) {
    editingTagId = id
    let isTagHidden = tagsRepository.findTag(with: id)?.isHidden ?? false
    hideAction.setValue((isTagHidden ? "Сделать активным" : "Скрыть"), forKey: "title")
    present(actionsAlertController, animated: true, completion: nil)
  }

  @objc private func onNewTagTap() {
    present(newTagAlertController, animated: true)
  }

  private func saveNewTag() {
    let alertTextField = self.newTagAlertController.textFields?.last
    guard let newTagName = alertTextField?.text,
          !newTagName.isEmpty else { return }
    tagsRepository.addNewTag(name: newTagName, groupId: groupId)
    onNeedToUpdateContent()
    alertTextField?.text?.removeAll()
  }

  private func setActionsForDeleteAlertController() {
    let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
      self.tagsRepository.deleteGroup(with: self.groupId)
      self.navigationController?.popViewController(animated: true)
      SPAlert.present(title: "Готово", message: "Группа удалена", preset: .done, haptic: .success)
    }

    let cancelAction = UIAlertAction(title: "Отмена", style: .default)

    [deleteAction, cancelAction].forEach { action in
      deleteGroupAlertController.addAction(action)
    }
  }
}

extension EditTagGroupVC: ViewControllerVMDelegate {
  func onNeedToUpdateContent() {
    DispatchQueue.main.async {
      guard let editTagVM = self.viewModel as? EditTagGroupVM else { return }
      editTagVM.generateCellsDataForTags()
      self.tableView.reloadData()
    }
  }
}
