import UIKit
import SnapKit
import SPIndicator

class NewNoteVC: BaseViewController {

	let viewModel = NewNoteVM(tableDataProvider: NewNoteTableDataProvider())
  let saveAlert = UIAlertController(title: "Attention", message: "Save new note?", preferredStyle: .alert)
  let clearAlert = UIAlertController(title: "Attention", message: "Clear all fields?", preferredStyle: .alert)

  lazy var tableView = TableView(viewModel: viewModel)

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.onUpdate() // need for updating height of tag cell
  }

	override func viewDidLoad() {
		super.viewDidLoad()
		setLayout()
	}

	private func setLayout() {
		setNavigationBar()
		addTableView()
    configureClearAlert()
	}

  func setLeftBarButton() {
    let leftButton = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(onClear))
    leftButton.tintColor = .orange
    navigationItem.leftBarButtonItem = leftButton
  }

  func setRightBarButton() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(onSave))
  }

  func setTitle() {
    title = "New note"
  }

	private func setNavigationBar() {
    setTitle()
    setLeftBarButton()
    setRightBarButton()
  }

  private func configureClearAlert() {
    let okAction = UIAlertAction(title: "Clear", style: .default) { _ in
      self.clearAllInput()
      SPIndicator.present(title: "Cleared", message: nil, preset: .done, from: .center, completion: nil)
    }
    let noAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)

    [okAction, noAction].forEach { action in
      clearAlert.addAction(action)
    }
  }

	private func addTableView() {
		view.addSubview(tableView)
		tableView.snp.makeConstraints { (make) in
			make.top.left.bottom.right.equalToSuperview()
		}
	}

  @objc func onSave() {
    self.navigationController?.tabBarController?.selectedIndex = 0
    self.viewModel.saveCurrentNote()
    self.clearAllInput()
    if let diaryVC = self.navigationController?
        .tabBarController?
        .viewControllers?[0]
        .children.first as? DiaryVC {
      diaryVC.updateData()
    }
    SPIndicator.present(title: "Note saved", message: nil, preset: .done, from: .top, completion: nil)
  }

  @objc private func onClear() {
    present(clearAlert, animated: true, completion: nil)
  }

  private func clearAllInput() {
    viewModel.clearInput()
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
}
