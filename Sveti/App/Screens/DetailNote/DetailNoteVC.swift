import UIKit
import SPIndicator

class DetailNoteVC: VCwithTable {

  private var note: Note?
  private let noteId: Int
  private let repository = NotesRepository()

  init(with tableStyle: UITableView.Style = .insetGrouped, noteId: Int) {
    self.noteId = noteId
    super.init(with: tableStyle)
  }

  override func getDataProvider() -> TableDataProvider? {
    self.note = repository.getNote(with: noteId)
    let dataProvider = DetailNoteTableDataProvider(with: noteId)
    return dataProvider
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func setLayout() {
    super.setLayout()
    navigationItem.largeTitleDisplayMode = .never
    addEditButton()
    setTitle(date: note?.splitDate)
  }

  private func setTitle(date: SplitDate?) {
    guard let date = date else {
      title = "Note"
      return
    }
    title = "\(date.dMMMMyyyy) в \(date.HHmm)"
  }

  private func addEditButton() {
    let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(onEdit))
    navigationItem.rightBarButtonItem = editButton
  }

  @objc private func onEdit() {
    let editVC = EditNoteVC(noteId: note?.id)
    editVC.onDismissal = { self.onEditingVCDismiss() }
    self.navigationController?.pushViewController(editVC, animated: true)
  }

  private func onEditingVCDismiss() {
    guard let note = self.note else { return }
    DispatchQueue.main.async { [self] in
      viewModel.tableDataProvider?.updateSections(with: note.id)
      tableView.registerCells()
      tableView.reloadData()
    }
    SPIndicator.present(title: "Note updated", preset: .done, haptic: .success, from: .top)
  }

  private func addTableView() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.top.left.right.bottom.equalToSuperview()
    }
  }

}
