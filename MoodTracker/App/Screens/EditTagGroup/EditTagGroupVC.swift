import UIKit
import ALPopup
import SPAlert

class EditTagGroupVC: VCwithTable {

  private let alertController = UIAlertController()
  let groupId: String
  private let tagsRepository = TagsRepository()
  var changingTagId = String() // Use for update tags in actionSheet called from TagGroupCell
  private var hideAction = UIAlertAction(title: "", style: .default)

  init(groupId: String) {
    self.groupId = groupId
    super.init(with: .insetGrouped)
    tableView = EditingTableView(viewModel: viewModel, style: .grouped)
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
    title = "Изменить"
    navigationItem.largeTitleDisplayMode = .never
    setAlertController()
  }

  private func setAlertController() {
    hideAction = UIAlertAction(title: "Скрыть", style: .default) { _ in
      self.tagsRepository.updateHidden(with: self.changingTagId)
      self.onNeedToUpdateContent()
    }

    let changeGroupAction = UIAlertAction(title: "Переместить", style: .default) { _ in
      let selectGroupVC = SelectGroupVC()
      var popupVC = ALCardController()

      selectGroupVC.moovingTagId = self.changingTagId
      selectGroupVC.markAsCurrentVC = false

      selectGroupVC.onSelectionCompletion = { groupTitle in
        popupVC.dismiss(animated: true)
        self.onNeedToUpdateContent()
        SPAlert.present(title: "Готово", message: "Таг перемещен в группу «\(groupTitle)»", preset: .done, haptic: .success)
      }

      popupVC = ALPopup.card(controller: selectGroupVC)
      popupVC.push(from: self)
    }

    let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
      self.tagsRepository.removeTag(with: self.changingTagId)
      self.onNeedToUpdateContent()
    }

    let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)

    [hideAction, changeGroupAction, deleteAction, cancelAction].forEach { action in
      alertController.addAction(action)
    }
  }

  func showEditAlert(forTag id: String) {
    changingTagId = id
    let isTagHidden = tagsRepository.findTag(with: id)?.isHidden ?? false
    hideAction.setValue((isTagHidden ? "Сделать активным" : "Скрыть"), forKey: "title")
    present(alertController, animated: true, completion: nil)
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
