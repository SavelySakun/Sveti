import UIKit

class BaseViewController: UIViewController {

  var markAsCurrentVC = true
  var onClosingCompletion: (() -> Void) = { return }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    guard markAsCurrentVC else { return }
    CurrentVC.current = self
    logOpenScreenEvent()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    hideKeyboardWhenTappedAround()
  }

  private func hideKeyboardWhenTappedAround() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    tapGesture.cancelsTouchesInView = false
    view.addGestureRecognizer(tapGesture)
  }

  @objc private func hideKeyboard() {
    view.endEditing(true)
  }

  /// Use for any data reload.
  func updateContent() {}

  /// Use for log any screen open events. Called in ViewDidAppear().
  func logOpenScreenEvent() {}
}
