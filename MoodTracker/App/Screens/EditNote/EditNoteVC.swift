import UIKit

class EditNoteVC: NewNoteVC {

  var onDismissal: (() -> Void)?

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    guard let dismissAction = onDismissal else { return }
    dismissAction()
  }

  init(noteId: Int? = nil) {
    super.init(nibName: nil, bundle: nil)

    guard let noteId = noteId else { return }
    let dataProvider = EditNoteTableDataProvider(with: NotesRepository().getNote(with: noteId))

    viewModel.setNote(with: noteId)
    viewModel.tableDataProvider = dataProvider
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  

}
