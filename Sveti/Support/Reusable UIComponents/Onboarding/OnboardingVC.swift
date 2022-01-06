import UIKit

class OnboardingVC: BaseViewController, IOnboardingController {

  var viewModel: IOnboardingVM

  // views
  private let onboardingContentView = OnboardingContentView()

  init(viewModel: IOnboardingVM) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func move(to: OnboardingMoveDirection) {
    //
  }

  func presentIfNeeded() {
    //
  }

  private func setLayout() {
    view.backgroundColor = .white
    setNavigationBar()
    setOnboardingContentView()
  }

  private func setNavigationBar() {
    setDefaultNavigationBarStyle()
    setCloseButton()
  }

  private func setDefaultNavigationBarStyle() {
    guard let navBar = navigationController?.navigationBar else { return }
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .white
    navBar.standardAppearance = appearance
    navBar.scrollEdgeAppearance = navBar.standardAppearance
  }

  private func setCloseButton() {
    let leftButton = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: self, action: #selector(onCancel))
    navigationItem.leftBarButtonItem = leftButton
  }

  @objc private func onCancel() {
    self.dismiss(animated: true)
  }

  private func setOnboardingContentView() {
    view.addSubview(onboardingContentView)
    onboardingContentView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }

  private func setInitialContent() {
    //
  }

}
