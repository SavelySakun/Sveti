import UIKit

class DiaryVC: UIViewController {

  private let emptyView = EmptyView()
  private let tableView = UITableView()
  private let viewModel = DiaryVM()

  override func viewDidLoad() {
    super.viewDidLoad()

    setLayout()
  }

  func updateData() {
    DispatchQueue.main.async { [self] in
      viewModel.loadNotes()
      updateEmptyViewVisibility()
      tableView.reloadData()
    }
  }

  private func setLayout() {
    title = "Дневник"
    navigationController?.navigationBar.prefersLargeTitles = true
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
    return DiaryTableSectionHeader(date: viewModel.sections[section].date)
  }


}
