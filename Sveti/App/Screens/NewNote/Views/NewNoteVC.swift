import UIKit
import SnapKit
import SPIndicator

class NewNoteVC: BaseViewController, ViewControllerVMDelegate {
  let viewModel = NewNoteVM(tableDataProvider: EditNoteTableDataProvider())
  let cancelAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIDevice.current.userInterfaceIdiom == .pad ? .alert : .actionSheet)

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
    setModalPresentation()
    viewModel.contentUpdateDelegate = self
    viewModel.informationDelegate = self
	}

	func setLayout() {
		setNavigationBar()
		addTableView()
    configureClearAlert()
	}

  private func setModalPresentation() {
    navigationController?.presentationController?.delegate = self
    isModalInPresentation = true
  }

  func setLeftBarButton() {
    let leftButton = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: self, action: #selector(onCancel))
    navigationItem.leftBarButtonItem = leftButton
  }

  func setRightBarButton() {
    let rightButton = UIBarButtonItem(title: "Save".localized, style: .done, target: self, action: #selector(onSave))
    navigationItem.rightBarButtonItem = rightButton
  }

  func setTitle() {
    title = "New note".localized
  }

	private func setNavigationBar() {
    setTitle()
    setLeftBarButton()
    setRightBarButton()
  }

  private func configureClearAlert() {
    let okAction = UIAlertAction(title: "Delete note draft".localized, style: .destructive) { _ in
      self.dismiss(animated: true)
    }
    let noAction = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)

    [okAction, noAction].forEach { action in
      cancelAlert.addAction(action)
    }
  }

	private func addTableView() {
    tableView.separatorStyle = .none
		view.addSubview(tableView)
		tableView.snp.makeConstraints { (make) in
			make.top.left.bottom.right.equalToSuperview()
		}
	}

  @objc func onSave() {
    SvetiAnalytics.log(.createNote)
    self.viewModel.saveCurrentNote()
    if let currentVC = CurrentVC.current as? BaseViewController {
      currentVC.updateContent()
    }
    self.dismiss(animated: true) {
      SPIndicator.present(title: "Note saved".localized, message: nil, preset: .done, from: .top, completion: nil)
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

  override func updateContent() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }

  func reloadContent() {
    updateContent()
  }
}

extension NewNoteVC: UIAdaptivePresentationControllerDelegate {
  func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
    present(cancelAlert, animated: true)
  }
}
