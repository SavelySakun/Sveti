import UIKit
import SnapKit
import SPIndicator

class NewNoteVC: BaseViewController {

  let viewModel = NewNoteVM(tableDataProvider: NewNoteTableDataProvider())
  let cancelAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

  lazy var tableView = TableView(viewModel: viewModel)

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.onUpdate() // need for updating height of tag cell
  }

  override func logOpenScreenEvent() {
    SvetiAnalytics.log(.NewNote)
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
    navigationItem.leftBarButtonItem = leftButton
  }

  func setRightBarButton() {
    let rightButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(onSave))
    rightButton.tintColor = .systemGreen
    navigationItem.rightBarButtonItem = rightButton
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
    let okAction = UIAlertAction(title: "Delete note draft", style: .destructive) { _ in
      self.dismiss(animated: true)
    }
    let noAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

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
    if let currentVC = CurrentVC.current as? BaseViewController {
      currentVC.updateContent()
    }
    self.dismiss(animated: true) {
      SPIndicator.present(title: "Note saved", message: nil, preset: .done, from: .top, completion: nil)
    }
  }

  @objc private func onCancel() {
    present(cancelAlert, animated: true, completion: nil)
  }

  private func clearAllInput() {
    viewModel.clearInput()
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
}
