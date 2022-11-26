import SPIndicator
import UIKit

class DetailNoteVC: VCwithTable {
    private var note: Note?
    private let noteId: Int
    private let repository = NotesRepository()

    init(with tableStyle: UITableView.Style = .insetGrouped, noteId: Int) {
        self.noteId = noteId
        super.init(with: tableStyle)
    }

    override func logOpenScreenEvent() {
        SvetiAnalytics.log(.DetailNote)
    }

    override func getDataProvider() -> TableDataProvider? {
        note = repository.getNote(with: noteId)
        let dataProvider = DetailNoteTableDataProvider(with: noteId)
        return dataProvider
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
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
            title = "Note".localized
            return
        }
        title = String(format: NSLocalizedString("%@ at %@", comment: ""), date.dMMMMyyyy, date.HHmm)
    }

    private func addEditButton() {
        let editButton = UIBarButtonItem(title: "Edit".localized, style: .plain, target: self, action: #selector(onEdit))
        navigationItem.rightBarButtonItem = editButton
    }

    @objc private func onEdit() {
        guard let note = note else { return }
        let editVC = EditNoteVC(noteId: note.id)
        editVC.onDismissal = { self.onEditingVCDismiss() }
        navigationController?.pushViewController(editVC, animated: true)
    }

    private func onEditingVCDismiss() {
        guard let note = note else { return }
        DispatchQueue.main.async { [self] in
            viewModel.tableDataProvider?.updateSections(with: note.id)
            tableView.registerCells()
            tableView.reloadData()
        }
        SPIndicator.present(title: "Note updated".localized, preset: .done, haptic: .success, from: .top)
    }

    private func addTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
