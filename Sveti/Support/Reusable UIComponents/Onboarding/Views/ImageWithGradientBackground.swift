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
    //setGradient()
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
    gradientLayer.frame = self.frame
    gradientLayer.colors = [UIColor.red.cgColor, UIColor.black.cgColor]
    layer.addSublayer(gradientLayer)
  }


}
