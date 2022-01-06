import UIKit

class OnboardingVC: UIViewController, IOnboardingController {

  var viewModel: IOnboardingVM

  init(viewModel: IOnboardingVM) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func move(to: OnboardingMoveDirection) {
    //
  }

  func presentIfNeeded() {
    //
  }

}
