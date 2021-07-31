import UIKit

class DetailNoteVC: BaseViewController {

  private var viewModel: ViewControllerVM!
  private lazy var tableView = TableView(sections: (viewModel.tableDataProvider?.sections)!, viewModel: viewModel)

  init(note: Note) {
    super.init(nibName: nil, bundle: nil)
    let dataProvider = DetailNoteTableDataProvider(with: note)
    viewModel = ViewControllerVM(tableDataProvider: dataProvider)
    setTitle(date: note.splitDate)
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
  }

  private func addTableView() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.top.left.right.bottom.equalToSuperview()
    }
  }

}
