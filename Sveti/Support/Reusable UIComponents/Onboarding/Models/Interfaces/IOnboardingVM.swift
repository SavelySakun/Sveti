import Foundation

protocol IOnboardingVM {
  var onboardingKey: String { get set }
  func updateOnboardingWatchStatus()
  func getOnboardingWatchStatus() -> Bool

  var slides: [OnboardingSlide] { get set }
}
