import UIKit
import SnapKit

enum RoundButtonState {
  case first
  case second
}

class RoundButtonView: UIView {

  private var firstStateImage: UIImage?
  private var secondStateImage: UIImage?

  var sizeSetupHandler: (() -> Void) = { return }
  var tapAction: (() -> Void) = { return }

  var sizeConstraint: Constraint?

  private var state: RoundButtonState = .first

  let imageView = UIImageView()
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = frame.size.width / 2
  }

  init(firstStateImage: String, secondStateImage: String? = nil) {
    super.init(frame: .zero)
    setStateImages(firstName: firstStateImage, secondName: secondStateImage)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setLayout() {
    backgroundColor = .white
    snp.makeConstraints { (make) in
      sizeConstraint = make.height.width.equalTo(33).constraint
    }
    setImageView()
    addTapAction()
  }

  func updateSize() {
    sizeConstraint?.deactivate()
    sizeSetupHandler()
  }

  private func setImageView() {
    imageView.image = firstStateImage
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = .black.withAlphaComponent(0.4)
    addSubview(imageView)
    imageView.snp.makeConstraints { (make) in
      make.height.width.equalTo(15)
      make.centerX.centerY.equalToSuperview()
    }
  }

  private func setStateImages(firstName: String, secondName: String?) {
    self.firstStateImage = UIImage(named: firstName)?.withRenderingMode(.alwaysTemplate)
    guard let secondName = secondName else { return }
    self.secondStateImage = UIImage(named: secondName)?.withRenderingMode(.alwaysTemplate)
  }

  func toggle() {
    DispatchQueue.main.async { [self] in
      let isFirstState = (state == .first)
      imageView.image = isFirstState ? secondStateImage : firstStateImage
      state = isFirstState ? .second : .first
    }
  }

  func setStateImage(isExpanded: Bool) {
    imageView.image = isExpanded ? secondStateImage : firstStateImage
  }

  private func addTapAction() {
    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
    self.addGestureRecognizer(gestureRecognizer)
    self.isUserInteractionEnabled = true
  }

  @objc private func onTap() {
    tapAction()
  }
}
