import UIKit

class DetailNoteVC: BaseViewController {

  private var viewModel: ViewControllerVM!
  private lazy var tableView = TableView(sections: (viewModel.tableDataProvider?.sections)!, viewModel: viewModel)
  private var note: Note?
  private let repository = NotesRepository()

  init(noteId: Int) {
    self.note = repository.getNote(with: noteId)
    super.init(nibName: nil, bundle: nil)
    let dataProvider = DetailNoteTableDataProvider(with: note)
    viewModel = ViewControllerVM(tableDataProvider: dataProvider)
    setTitle(date: note?.splitDate)
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

  override func viewDidLoad() {
    super.viewDidLoad()
    setLayout()
  }

  private func setLayout() {
    addTableView()
    addEditButton()
  }

  private func addEditButton() {
    let editButton = UIBarButtonItem(title: "Изменить", style: .plain, target: self, action: #selector(onEdit))
    navigationItem.rightBarButtonItem = editButton
  }

  @objc private func onEdit() {
    let editVC = EditNoteVC(noteId: note?.id)
    editVC.onDismissal = { self.onEditingVCDismiss() }
    present(editVC, animated: true)
  }

  private func onEditingVCDismiss() {
    guard let note = self.note else { return }
    self.note = self.repository.getNote(with: note.id)
    let dataProvider = DetailNoteTableDataProvider(with: note)
    self.viewModel = ViewControllerVM(tableDataProvider: dataProvider)
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }

  private func addTableView() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.top.left.right.bottom.equalToSuperview()
    }
  }

}
