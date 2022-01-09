import UIKit

class SvetiOnboardingVC: OnboardingVC {
  init() {
    let slides = TestHelper.isTestMode ? OnboardingSlides.testSlides : OnboardingSlides.svetiOnboarding
    super.init(viewModel: OnboardingVM(userDefaultsKey: UDKeys.isSvetiOnboardingShown, slides: slides))
    title = "Welcome to Sveti"
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
