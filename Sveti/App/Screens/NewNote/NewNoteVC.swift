import UIKit
import SnapKit
import SPIndicator

class NewNoteVC: BaseViewController {

    let viewModel = NewNoteVM(tableDataProvider: NewNoteTableDataProvider())
  let saveAlert = UIAlertController(title: "Attention", message: "Save new note?", preferredStyle: .alert)
  let cancelAlert = UIAlertController(title: "Attention", message: "You will lose all changes.", preferredStyle: .alert)

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
    let leftButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(onCancel))
    leftButton.tintColor = .systemRed
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
    let okAction = UIAlertAction(title: "Clear", style: .destructive) { _ in
      self.dismiss(animated: true)
    }
    let noAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)

    [okAction, noAction].forEach { action in
      cancelAlert.addAction(action)
    }
  }

	private func addTableView() {
		view.addSubview(tableView)
		tableView.snp.makeConstraints { (make) in
			make.top.left.bottom.right.equalToSuperview()
		}
	}

  @objc func onSave() {
    self.viewModel.saveCurrentNote()
    if let diaryVC = CurrentVC.current as? DiaryVC {
      diaryVC.updateData()
    }
    self.dismiss(animated: true) {
      SPIndicator.present(title: "Note saved", message: nil, preset: .done, from: .top, completion: nil)
    }
//    self.navigationController?.tabBarController?.selectedIndex = 0
//    self.viewModel.saveCurrentNote()
//    self.clearAllInput()
//    if let diaryVC = self.navigationController?
//        .tabBarController?
//        .viewControllers?[0]
//        .children.first as? DiaryVC {
//      diaryVC.updateData()
//    }

  }

  @objc private func onCancel() {
    if viewModel.hasChanges {
      present(cancelAlert, animated: true, completion: nil)
    } else {
      self.dismiss(animated: true, completion: nil)
    }
  }

  private func clearAllInput() {
    viewModel.clearInput()
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
}
