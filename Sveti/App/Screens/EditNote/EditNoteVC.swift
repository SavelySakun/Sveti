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
    title = "Изменить"
  }

  override func setLeftBarButton() {
    let leftButton = UIBarButtonItem(title: "Удалить", style: .plain, target: self, action: #selector(onDelete))
    leftButton.tintColor = .red
    navigationItem.leftBarButtonItem = leftButton
  }

  @objc func onDelete() {
    guard let noteId = self.noteId,
          let note = NotesRepository().getNote(with: noteId) else { return }
    StatDaysManager().removeStat(with: note)
    NotesRepository().deleteNote(noteId: noteId)
    SPIndicator.present(title: "Запись удалена", preset: .done, haptic: .success, from: .top)
    self.navigationController?.popToRootViewController(animated: true)
  }

  override func onSave() {
    guard let dismissAction = onDismissal else { return }
    dismissAction()
    self.navigationController?.popViewController(animated: true)
  }
}
