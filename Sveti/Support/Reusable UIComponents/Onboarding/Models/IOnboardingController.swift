import Foundation

protocol IOnboardingController {
  var onboardingKey: String { get set }
  func updateOnboardingWatchStatus()
  func getOnboardingWatchStatus() -> Bool

  var slides: [OnboardingSlide] { get set }
  func move(to: OnboardingMoveDirection)

  func presentIfNeeded()
}
