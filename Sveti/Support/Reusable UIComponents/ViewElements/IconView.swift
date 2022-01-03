import UIKit

class IconView: UIView {

  private let imageView = UIImageView()
  var image: UIImage? {
    didSet { setImage(image) }
  }
  var iconTintColor: UIColor = .white {
    didSet { imageView.tintColor = iconTintColor }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setLayout() {
    addSubview(imageView)
    imageView.snp.makeConstraints { (make) in
      make.height.width.equalToSuperview().multipliedBy(0.65)
      make.centerX.centerY.equalToSuperview()
    }
  }

  private func setImage(_ image: UIImage?) {
    guard let image = image else { return }
    imageView.tintColor = iconTintColor
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
  }
}
