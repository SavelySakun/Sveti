import UIKit

class RoundButtonView: UIView {

  private let imageView = UIImageView()
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = frame.size.width / 2
  }

  init(icon: String) {
    super.init(frame: .zero)
    imageView.image = UIImage(named: icon)?.withRenderingMode(.alwaysTemplate)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setLayout() {
    backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1).withAlphaComponent(0.5)
    snp.makeConstraints { (make) in
      make.height.width.equalTo(33)
    }

    setImageView()
  }

  private func setImageView() {
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = .black.withAlphaComponent(0.4)
    addSubview(imageView)
    imageView.snp.makeConstraints { (make) in
      make.height.width.equalTo(15)
      make.centerX.centerY.equalToSuperview()
    }
  }

}
