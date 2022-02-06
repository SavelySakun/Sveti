import UIKit
import SPAlert
import SPIndicator

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

  func makeHapticFeedback() {
    var feedbackGenerator: UISelectionFeedbackGenerator? = UISelectionFeedbackGenerator()
    feedbackGenerator?.prepare()
    feedbackGenerator?.selectionChanged()
    feedbackGenerator = nil
  }
}

extension BaseViewController: InformationDelegate {
  func showUpdatedAlert() {
    DispatchQueue.main.async {
      SPIndicator.present(title: "Updated".localized, message: nil, preset: .done, from: .top, completion: nil)
    }
  }

  func showCompleteAlert(title: String, message: String, image: UIImage?) {
    DispatchQueue.main.async {
      let preset: SPAlertIconPreset
      if let existingImage = image {
        preset = .custom(existingImage.withRenderingMode(.alwaysTemplate))
      } else {
        preset = .done
      }
      let alertView = SPAlertView(title: title, message: message, preset: preset)
      alertView.duration = 2.0
      alertView.present()
    }
  }

  func showAlert(title: String?, message: String, actions: [UIAlertAction]?, completion: (() -> Void)?) {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      if let actions = actions {
        actions.forEach { alert.addAction($0) }
      } else {
        alert.addAction(UIAlertAction(title: "OK", style: .default))
      }
      self.navigationController?.present(alert, animated: true) {
        completion?()
      }
    }
  }

  func updateLoadingIndicator(show: Bool) {
    DispatchQueue.main.async { [self] in
      show ? activitiIndicator.startAnimating() : activitiIndicator.stopAnimating()
    }
  }


}
