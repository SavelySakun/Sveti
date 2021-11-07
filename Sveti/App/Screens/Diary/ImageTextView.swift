import UIKit

class ImageTextView: UIView {
  private let imageView = UIImageView()
  private let textLabel = UILabel()

  init(imageName: String, text: String) {
    super.init(frame: .zero)
    let iconImage = UIImage(named: imageName)
    imageView.image = iconImage
    textLabel.text = text
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setLayout() {
    imageView.tintColor = .systemBlue
    imageView.contentMode = .scaleAspectFit
    textLabel.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
    textLabel.numberOfLines = 0
    textLabel.textAlignment = .center
    addSubview(imageView)
    addSubview(textLabel)
    imageView.snp.makeConstraints { (make) in
      make.top.left.right.equalToSuperview()
    }
    textLabel.snp.makeConstraints { (make) in
      make.top.equalTo(imageView.snp.bottom).offset(10)
      make.right.bottom.left.equalToSuperview()
      make.height.lessThanOrEqualTo(80)
    }
  }

}
