import UIKit

class DiaryVC: UIViewController {

  private let tableView = UITableView()
  private let viewModel = DiaryVM()

  override func viewDidLoad() {
    super.viewDidLoad()

    setLayout()
  }

  func updateData() {
    DispatchQueue.main.async { [self] in
      viewModel.loadNotes()
      tableView.reloadData()
    }
  }

  private func setLayout() {
    title = "Дневник"
    navigationController?.navigationBar.prefersLargeTitles = true
    setTable()
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
}

extension DiaryVC: UITableViewDelegate {

}

extension DiaryVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.notes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryCell", for: indexPath) as? DiaryCell else { return UITableViewCell() }
    let note = viewModel.notes[indexPath.row]
    cell.configure(with: note)
    return cell
  }


}
