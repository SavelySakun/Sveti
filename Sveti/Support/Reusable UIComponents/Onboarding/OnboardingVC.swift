import UIKit

class OnboardingVC: BaseViewController, IOnboardingController {

  var viewModel: IOnboardingVM
  private let nextButton = UIButton()
  private let backButton = UIButton()

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
    setNextButton()
    setBackButon()
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

  private func setNextButton() {
    nextButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
    nextButton.backgroundColor = .systemBlue
    nextButton.contentMode = .center
    nextButton.imageView?.snp.makeConstraints { (make) in
      make.width.height.equalToSuperview().multipliedBy(0.6)
    }
    nextButton.tintColor = .white
    nextButton.layer.cornerRadius = 35

    view.addSubview(nextButton)
    nextButton.snp.makeConstraints { (make) in
      make.width.height.equalTo(70)
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview().offset(-80)
    }
  }

  private func setBackButon() {
    view.addSubview(backButton)
    backButton.setTitle("Back", for: .normal)
    backButton.setTitleColor(.systemBlue, for: .normal)

    backButton.snp.makeConstraints { (make) in
      make.right.equalTo(nextButton.snp.left).offset(-40)
      make.height.equalTo(50)
      make.width.equalTo(nextButton.snp.width)
      make.centerY.equalTo(nextButton.snp.centerY)
    }
  }

}
