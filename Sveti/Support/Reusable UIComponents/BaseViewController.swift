import UIKit

class BaseViewController: UIViewController {

  var markAsCurrentVC = true
  var onClosingCompletion: (() -> Void) = { return }
  var activitiIndicator = UIActivityIndicatorView(style: .large)

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

  func setActivityIndicator() {
    view.addSubview(activitiIndicator)
    activitiIndicator.layer.cornerRadius = 12
    activitiIndicator.backgroundColor = .white.withAlphaComponent(0.7)
    activitiIndicator.color = .systemGray
    activitiIndicator.hidesWhenStopped = true

    activitiIndicator.snp.makeConstraints { (make) in
      make.centerX.centerY.equalToSuperview()
      make.width.height.equalTo(120)
    }
  }

  func startActivityIndicator() {
    DispatchQueue.main.async {
      self.activitiIndicator.startAnimating()
    }
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
