import UIKit

class SvetiOnboardingVC: OnboardingVC {
  init() {
    super.init(viewModel: OnboardingVM(key: "SvetiOnboarding", slides: [
      OnboardingSlide(title: "1", subtitle: "", globalBackgroundColor: .red, image: UIImage(named: "noDataFilter")),
      OnboardingSlide(title: "2", subtitle: "", globalBackgroundColor: .blue, image: UIImage(named: "noDataFilter")),
      OnboardingSlide(title: "3", subtitle: "", globalBackgroundColor: .red, image: UIImage(named: "noDataFilter")),
    ]))
    title = "Welcome to Sveti"
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
