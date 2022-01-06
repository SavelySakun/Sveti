import Foundation

class OnboardingVM: IOnboardingVM {

  var onboardingKey: String
  var slides: [OnboardingSlide]

  init(key: String, slides: [OnboardingSlide]) {
    self.onboardingKey = key
    self.slides = slides
  }

  func updateOnboardingWatchStatus() {
    //
  }

  func getOnboardingWatchStatus() -> Bool {
    true
  }

}


