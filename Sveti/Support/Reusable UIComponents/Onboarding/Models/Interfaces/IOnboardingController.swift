import UIKit

protocol IOnboardingController {
    var viewModel: IOnboardingVM { get set }
    func presentIfNeeded(from parent: UIViewController)
    func move(to: OnboardingMoveDirection)
    func trackEarlyExit()
    func trackOnboardingFinished()
}
