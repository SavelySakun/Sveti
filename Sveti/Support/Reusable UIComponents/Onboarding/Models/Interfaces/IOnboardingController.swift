import Foundation

protocol IOnboardingController {
  var viewModel: IOnboardingVM { get set }
  func presentIfNeeded()
  func move(to: OnboardingMoveDirection)
}
