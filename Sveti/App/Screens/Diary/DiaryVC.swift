import UIKit

class DiaryVC: BaseViewController {

  private let emptyView = ImageTextView(imageName: "2cats", text: "Add the first note in the \"New note\" section")
  private let tableView = UITableView()
  private let viewModel = DiaryVM()

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.updateContent()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setLayout()
  }

  override func updateContent() {
    DispatchQueue.main.async { [self] in
      viewModel.loadNotes()
      updateEmptyViewVisibility()
      tableView.reloadData()
    }
  }

  private func setLayout() {
    title = "Diary"
    setTable()
    setEmptyView()
  }

  private func setTable() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(DiaryCell.self, forCellReuseIdentifier: "DiaryCell")
    tableView.separatorStyle = .none

    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.top.left.bottom.right.equalToSuperview()
    }
  }

  private func setEmptyView() {
    view.addSubview(emptyView)
    updateEmptyViewVisibility()
    emptyView.snp.makeConstraints { (make) in
      make.height.equalToSuperview().multipliedBy(0.3)
      make.width.equalToSuperview().multipliedBy(0.6)
      make.centerX.centerY.equalToSuperview()
    }
  }

  private func updateEmptyViewVisibility() {
    emptyView.isHidden = !viewModel.sections.isEmpty
  }
}

extension DiaryVC: UITableViewDelegate {

}

extension DiaryVC: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    viewModel.sections.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.sections[section].notes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryCell", for: indexPath) as? DiaryCell else { return UITableViewCell() }
    let note = viewModel.sections[indexPath.section].notes[indexPath.row]
    cell.configure(with: note)
    return cell
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let sectionItem = viewModel.sections[section]
    return DiaryTableSectionHeader(date: sectionItem.date, averageScore: sectionItem.average)
  }

  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

    let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (_, _, completion) in
      let noteToDeleteId = self.viewModel.sections[indexPath.section].notes[indexPath.row].id
      self.viewModel.deleteNote(noteId: noteToDeleteId)
      completion(true)
      self.updateContent()
    }

    let image = UIImage(named: "Delete")?.imageResized(to: .init(width: 22, height: 22))
    deleteAction.image = image
    deleteAction.backgroundColor = .white
    return UISwipeActionsConfiguration(actions: [deleteAction])
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedNote = viewModel.sections[indexPath.section].notes[indexPath.row]
    let detailNoteVC = DetailNoteVC(noteId: selectedNote.id)
    self.navigationController?.pushViewController(detailNoteVC, animated: true)
  }

}
