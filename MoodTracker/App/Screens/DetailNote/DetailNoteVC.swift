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
    let dataProvider = DetailNoteTableDataProvider(with: note)
    return dataProvider
  }

  private func setTitle(date: SplitDate?) {
    guard let date = date else {
      title = "Заметка"
      return
    }
    title = "\(date.dMMMMyyyy) в \(date.HHmm)"
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func setLayout() {
    super.setLayout()
    addEditButton()
  }

  private func addEditButton() {
    let editButton = UIBarButtonItem(title: "Изменить", style: .plain, target: self, action: #selector(onEdit))
    navigationItem.rightBarButtonItem = editButton
  }

  @objc private func onEdit() {
    let editVC = EditNoteVC(noteId: note?.id)
    editVC.onDismissal = { self.onEditingVCDismiss() }
    self.navigationController?.pushViewController(editVC, animated: true)
  }

  private func onEditingVCDismiss() {
    guard let note = self.note else { return }

    self.note = self.repository.getNote(with: note.id)
    let dataProvider = DetailNoteTableDataProvider(with: note)
    self.viewModel = ViewControllerVM(tableDataProvider: dataProvider)
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
    SPIndicator.present(title: "Запись обновлена", preset: .done, haptic: .success, from: .top)
  }

  private func addTableView() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.top.left.right.bottom.equalToSuperview()
    }
  }

}
