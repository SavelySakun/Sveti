import Foundation

class SvetiOnboardingVC: OnboardingVC {
  init() {
    super.init(viewModel: OnboardingVM(key: "SvetiOnboarding", slides: []))
    title = "Welcome to Sveti"
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
