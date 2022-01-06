import UIKit

class OnboardingVC: UIViewController, IOnboardingController {

  var onboardingKey: String
  var slides: [OnboardingSlide]

  init(with slides: [OnboardingSlide], key: String) {
    self.onboardingKey = key
    self.slides = slides

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func updateOnboardingWatchStatus() {
    //
  }

  func getOnboardingWatchStatus() -> Bool {
    return false
  }

  func move(to: OnboardingMoveDirection) {
    //
  }

  func presentIfNeeded() {
    //
  }

}
