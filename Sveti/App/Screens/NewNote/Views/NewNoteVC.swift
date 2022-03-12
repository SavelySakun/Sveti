import UIKit
import SnapKit
import SPIndicator
import SPConfetti

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
    showSavedIndicator()
    SvetiAnalytics.log(.createNote)
    self.viewModel.saveCurrentNote()
    if let currentVC = CurrentVC.current as? BaseViewController {
      currentVC.updateContent()
    }
    self.dismiss(animated: true)
  }

  private func showSavedIndicator() {
    var textForIndicator = "Note saved".localized
    var imageName = "done"
    if viewModel.isFirstNoteForToday() {
      showConfetti()
      textForIndicator = "First note for today!".localized
      imageName = "confetti"
    }
    guard let image = UIImage(named: imageName) else { return }
    SPIndicator.present(title: textForIndicator, message: nil, preset: .custom(image), from: .top, completion: nil)
  }

  private func showConfetti() {
    let availableParticles: [SPConfettiParticle] = [.heart, .star, .circle, .polygon, .arc, .triangle]
    let randomIndex = Int.random(in: 0...(availableParticles.count - 1))
    let selectedRandomParticle = availableParticles[randomIndex]
    SPConfettiConfiguration.particlesConfig.colors = [#colorLiteral(red: 1, green: 0.7400508523, blue: 0.7330603004, alpha: 1), #colorLiteral(red: 1, green: 0.7764705882, blue: 1, alpha: 1), #colorLiteral(red: 0.6078431373, green: 0.9647058824, blue: 1, alpha: 1), #colorLiteral(red: 0.7921568627, green: 1, blue: 0.7490196078, alpha: 1)]
    SPConfetti.startAnimating(.fullWidthToDown, particles: [selectedRandomParticle], duration: 1)
    UINotificationFeedbackGenerator().notificationOccurred(.success)
  }

  @objc private func onCancel() {
    if viewModel.hasChanges {
      present(cancelAlert, animated: true, completion: nil)
    } else {
      dismiss(animated: true)
    }
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
    onCancel()
  }
}
