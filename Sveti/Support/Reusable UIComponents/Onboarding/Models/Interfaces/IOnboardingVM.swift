import Foundation

protocol IOnboardingVM {
  var onboardingKey: String { get set }
  func updateOnboardingWatchStatus()
  func getOnboardingWatchStatus() -> Bool
  func updateOnboardingProgression(direction: OnboardingMoveDirection)
  func getSlide() -> OnboardingSlide?
  func getOnboardingProgressionValue() -> Float

  var slides: [OnboardingSlide] { get set }
  var currentSlideIndex: Int { get set }
  var onboardingState: OnboardingState { get set }
}
