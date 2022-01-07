import UIKit

class ImageWithGradientBackground: UIView {

  private let imageView = UIImageView()
  private let gradientLayer = CAGradientLayer()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setLayout() {
    setImageView()
  }

  private func setImageView() {
    addSubview(imageView)
    imageView.image = UIImage(named: "purrDate")
    imageView.contentMode = .scaleAspectFit
    imageView.snp.makeConstraints { (make) in
      make.centerX.centerY.equalToSuperview()
      make.width.height.equalToSuperview().multipliedBy(0.8)
    }
  }

  private func setGradient() {
  }

  func update(slide: OnboardingSlide) {
    gradientLayer.frame = bounds
    gradientLayer.colors = [UIColor.orange.cgColor, UIColor.blue.cgColor]
    gradientLayer.cornerRadius = 12
    layer.insertSublayer(gradientLayer, at: 0)
    imageView.image = slide.image
  }


}
