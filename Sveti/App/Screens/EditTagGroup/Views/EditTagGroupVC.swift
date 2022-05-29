import UIKit
import ALPopup
import SPAlert

class EditTagGroupVC: VCwithTable {

    // - MARK: AlertControllers & Action
    private let actionsAlertController = UIAlertController()
    private let newTagAlertController = UIAlertController(title: "Add a tag".localized, message: nil, preferredStyle: .alert)
    private let deleteGroupAlertController = UIAlertController(title: "Attention".localized, message: "Delete group?".localized, preferredStyle: .alert)
    private var hideAction = UIAlertAction(title: "", style: .default)

    // - MARK: Editing utils
    let groupId: String
    var editingTagId = String() // Use for update tags in actionSheet called from TagGroupCell
    var showDeleteButton: Bool = true

    // - MARK: Repo
    private let tagsRepository = TagsRepository()

    // - MARK: Internal
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

    override func logOpenScreenEvent() {
        SvetiAnalytics.log(.EditTagGroup)
    }

    override func getDataProvider() -> TableDataProvider? {
        EditTagGroupTableDataProvider(with: groupId)
    }

    override func setViewModel(with dataProvider: TableDataProvider) {
        viewModel = EditTagGroupVM(tableDataProvider: dataProvider, tagGroupId: groupId)
        viewModel.contentUpdateDelegate = self
    }

    override func setLayout() {
        super.setLayout()
        tableView.separatorColor = .clear
        tableView.isEditing = true
        tableView.eventDebounceValue = 0

        setTableFooter()

        title = "Edit".localized
        navigationItem.largeTitleDisplayMode = .never
        setActionsAlertController()
        setNewTagButton()
        setNewTagAlert()
        setActionsForDeleteAlertController()
    }

    func showEditAlert(forTag id: String) {
        editingTagId = id
        let isTagHidden = tagsRepository.findTag(withId: id)?.isHidden ?? false
        hideAction.setValue((isTagHidden ? "Make active".localized : "Hide".localized), forKey: "title")
        present(actionsAlertController, animated: true, completion: nil)
    }

    // - MARK: Private
    private func setTableFooter() {
        let footerView = DeleteTableFooter(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        footerView.deleteButton.setTitle("Delete group".localized, for: .normal)
        footerView.onDeleteTapHandler = {
            self.present(self.deleteGroupAlertController, animated: true, completion: nil)
        }
        tableView.tableFooterView = footerView
        tableView.tableFooterView?.isHidden = !showDeleteButton
    }

    private func setNewTagButton() {
        let button = UIButton()
        button.snp.makeConstraints { (make) in
            make.height.width.equalTo(32)
        }
        let image = UIImage(named: "add")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .systemGreen
        button.addTarget(self, action: #selector(onNewTagTap), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }

    private func setNewTagAlert() {
        newTagAlertController.addTextField { textField in
            textField.placeholder = "Tag name".localized
        }

        let addAction = UIAlertAction(title: "Add".localized, style: .default) { _ in
            self.saveNewTag()
        }

        let dismissAction = UIAlertAction(title: "Cancel".localized, style: .cancel) { _ in
            self.newTagAlertController.textFields?.last?.text?.removeAll()
        }

        [addAction, dismissAction].forEach { action in
            newTagAlertController.addAction(action)
        }
    }

    private func setActionsAlertController() {
        hideAction = UIAlertAction(title: "Hide".localized, style: .default) { _ in
            self.tagsRepository.updateTagHiddenStatus(withId: self.editingTagId)
            self.reloadContent()
            SvetiAnalytics.log(.hideTag)
        }

        let changeGroupAction = UIAlertAction(title: "Move to group".localized, style: .default) { _ in
            let selectGroupVC = SelectGroupVC(with: self.groupId)
            var popupVC = ALCardController()

            selectGroupVC.moovingTagId = self.editingTagId
            selectGroupVC.markAsCurrentVC = false

            selectGroupVC.onSelectionCompletion = { groupTitle in
                popupVC.dismiss(animated: true)
                self.reloadContent()
                SPAlert.present(title: "Done".localized, message: "Tag moved to «\(groupTitle)»".localized, preset: .done, haptic: .success)
                SvetiAnalytics.log(.moveTag)
            }

            popupVC = ALPopup.card(controller: selectGroupVC)
            popupVC.push(from: self)
        }

        let deleteAction = UIAlertAction(title: "Delete".localized, style: .destructive) { _ in
            self.showAlertAboutRemoveTagInOldNotes()
        }

        let cancelAction = UIAlertAction(title: "Discard".localized, style: .cancel)

        [hideAction, changeGroupAction, deleteAction, cancelAction].forEach { action in
            actionsAlertController.addAction(action)
        }
    }

    private func showAlertAboutRemoveTagInOldNotes() {
        let okAction = UIAlertAction(title: "Display", style: .default)
        let deleteAction = UIAlertAction(title: "Remove", style: .default) { _ in
            NotesRepository().removeTagFromNotes(tagId: self.editingTagId)
        }

        self.showAlert(title: "Attention".localized, message: "Display a deleted tag in existing notes?", actions: [okAction, deleteAction]) {
            self.removeTag()
        }
    }

    private func removeTag() {
        self.tagsRepository.removeTag(withId: self.editingTagId)
        self.reloadContent()
        SvetiAnalytics.log(.deleteTag)
    }


    @objc private func onNewTagTap() {
        present(newTagAlertController, animated: true)
    }

    private func saveNewTag() {
        let alertTextField = self.newTagAlertController.textFields?.last
        guard let newTagName = alertTextField?.text,
              !newTagName.isEmpty else { return }
        tagsRepository.addNewTag(withName: newTagName, groupId: groupId)
        reloadContent()
        alertTextField?.text?.removeAll()
        SvetiAnalytics.log(.addTag)
    }

    private func setActionsForDeleteAlertController() {
        let deleteAction = UIAlertAction(title: "Delete".localized, style: .destructive) { _ in
            self.tagsRepository.deleteGroup(with: self.groupId)
            self.navigationController?.popViewController(animated: true)
            SPAlert.present(title: "Done".localized, message: "Group deleted".localized, preset: .done, haptic: .success)
            SvetiAnalytics.log(.deleteTagGroup)
        }

        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .default)

        [deleteAction, cancelAction].forEach { action in
            deleteGroupAlertController.addAction(action)
        }
    }
}

extension EditTagGroupVC: ViewControllerVMDelegate {
    func reloadContent() {
        DispatchQueue.main.async { [self] in
            UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve) {
                guard let editTagVM = self.viewModel as? EditTagGroupVM else { return }
                editTagVM.generateCellsDataForTags()
                self.tableView.reloadData()
            }
        }
    }
}
