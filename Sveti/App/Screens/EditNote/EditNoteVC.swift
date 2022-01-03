import UIKit
import SPIndicator

class EditNoteVC: NewNoteVC {

  var onDismissal: (() -> Void)?
  var noteId: Int?

  init(noteId: Int? = nil) {
    super.init(nibName: nil, bundle: nil)
    guard let noteId = noteId else { return }
    self.noteId = noteId
    let dataProvider = EditNoteTableDataProvider(with: NotesRepository().getNote(with: noteId))
    viewModel.setNote(with: noteId)
    viewModel.tableDataProvider = dataProvider
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func setTitle() {
    title = "Edit".localized
  }

  override func setLeftBarButton() {
    return // On edit note screen we don't need custom left bar button
  }

  override func logOpenScreenEvent() {
    SvetiAnalytics.log(.EditNote)
  }

  override func onSave() {
    guard let dismissAction = onDismissal else { return }
    dismissAction()
    SvetiAnalytics.log(.editNote)
    self.navigationController?.popViewController(animated: true)
  }

  override func setLayout() {
    super.setLayout()
    setTableFooter()
  }

  private func setTableFooter() {
    let footerView = DeleteTableFooter(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
    footerView.onDeleteTapHandler = { self.onDelete() }
    tableView.tableFooterView = footerView
  }

  @objc func onDelete() {
    guard let noteId = self.noteId,
          let note = NotesRepository().getNote(with: noteId) else { return }
    StatDaysDataManager().removeStat(with: note)
    NotesRepository().deleteNote(noteId: noteId)
    SPIndicator.present(title: "Note deleted".localized, preset: .done, haptic: .success, from: .top)
    SvetiAnalytics.log(.deleteNote)
    self.navigationController?.popToRootViewController(animated: true)
  }
}
