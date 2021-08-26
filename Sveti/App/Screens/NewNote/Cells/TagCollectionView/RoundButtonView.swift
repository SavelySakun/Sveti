import UIKit
import SnapKit

enum RoundButtonState {
  case first
  case second
}

class RoundButtonView: UIButton {

  private var firstStateImage: UIImage?
  private var secondStateImage: UIImage?
  var backColor: UIColor? { didSet { backgroundColor = backColor } }

  var sizeSetupHandler: (() -> Void) = { return }
  var tapAction: (() -> Void) = { return }

  var sizeConstraint: Constraint?

  private var selectionState: RoundButtonState = .first

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
      sizeConstraint = make.height.width.equalTo(35).constraint
    }
    setImageView()
    addTapAction()
  }

  func updateSize() {
    sizeConstraint?.deactivate()
    sizeSetupHandler()
  }

  private func setImageView() {
    setImage(firstStateImage, for: .normal)
    imageView?.contentMode = .scaleAspectFit
    imageView?.tintColor = .black.withAlphaComponent(0.4)
    imageView?.snp.makeConstraints { (make) in
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
    guard secondStateImage != nil else { return }
    DispatchQueue.main.async { [self] in
      let isFirstState = (selectionState == .first)
      let image = isFirstState ? secondStateImage : firstStateImage
      imageView?.image = image
      selectionState = isFirstState ? .second : .first
    }
  }

  func setStateImage(isExpanded: Bool) {
    let image = isExpanded ? secondStateImage : firstStateImage
    setImage(image, for: .normal)
  }

  private func addTapAction() {
    addTarget(self, action: #selector(onTap), for: .touchUpInside)
  }

  @objc private func onTap() {
    var feedbackGenerator: UISelectionFeedbackGenerator? = UISelectionFeedbackGenerator()
    feedbackGenerator?.prepare()
    feedbackGenerator?.selectionChanged()
    UIView.animate(withDuration: 0.3) {
      self.toggle()
      self.backgroundColor = .systemGray4
      self.backgroundColor = self.backColor ?? .white
    }
    tapAction()
    feedbackGenerator = nil
  }
}
