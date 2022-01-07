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

  private func setLayout() {
    view.backgroundColor = .white
    setNavigationBar()
    setOnboardingContentView()
    setNextButton()
    setBackButon()
    setInitialContent()
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
    guard let slide = viewModel.getSlide() else { return }
    onboardingContentView.updateContent(slide: slide, progression: 0.0)
    updateButtonsState()
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
    nextButton.addTarget(self, action: #selector(onNextTap), for: .touchUpInside)

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
    backButton.addTarget(self, action: #selector(onBackTap), for: .touchUpInside)
    backButton.snp.makeConstraints { (make) in
      make.right.equalTo(nextButton.snp.left).offset(-40)
      make.height.equalTo(50)
      make.width.equalTo(nextButton.snp.width)
      make.centerY.equalTo(nextButton.snp.centerY)
    }
  }

  @objc private func onNextTap() {
    move(to: .next)
  }

  @objc private func onBackTap() {
    move(to: .back)
  }

  func move(to direction: OnboardingMoveDirection) {
    makeHapticFeedback()
    viewModel.updateOnboardingProgression(direction: direction)
    updateButtonsState()
    showSlideOrDismiss()
  }

  func updateButtonsState() {
    let state = viewModel.onboardingState
    let buttonImageName = (state == .hasSlides || state == .firstSlide) ? "arrow.right" : "checkmark"
    let buttonBackground: UIColor = (state == .lastSlide) ? #colorLiteral(red: 0.2049866915, green: 0.6625028849, blue: 0.5520762801, alpha: 1) : .systemBlue

    DispatchQueue.main.async { [self] in
      UIView.transition(with: backButton, duration: 0.4, options: .transitionCrossDissolve) {
        backButton.isHidden = (state == .firstSlide)
      }
      UIView.transition(with: nextButton, duration: 0.4, options: .transitionCrossDissolve) {
        nextButton.setImage(UIImage(systemName: buttonImageName), for: .normal)
        nextButton.backgroundColor = buttonBackground
      }
    }
  }

  func presentIfNeeded() {
    //
  }

  private func showSlideOrDismiss() {
    if let slide = viewModel.getSlide() {
      onboardingContentView.updateContent(slide: slide, progression: viewModel.getOnboardingProgressionValue())
    } else {
      dismiss(animated: true)
    }
  }

  private func makeHapticFeedback() {
    var feedbackGenerator: UISelectionFeedbackGenerator? = UISelectionFeedbackGenerator()
    feedbackGenerator?.prepare()
    feedbackGenerator?.selectionChanged()
    feedbackGenerator = nil
  }

}
