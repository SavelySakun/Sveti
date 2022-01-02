import UIKit

class ImageTextView: UIView {
  let imageView = UIImageView()
  let textLabel = UILabel()
  let contentStackView = UIStackView()

  init() {
    super.init(frame: .zero)
    setLayout()
  }

  init(imageName: String, text: String) {
    super.init(frame: .zero)
    setContent(imageName: imageName, text: text)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setContent(imageName: String, text: String) {
    let iconImage = UIImage(named: imageName)
    imageView.image = iconImage
    textLabel.text = text
  }

  private func setLayout() {
    imageView.tintColor = .systemBlue
    imageView.contentMode = .scaleAspectFit
    textLabel.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
    textLabel.numberOfLines = 0
    textLabel.textAlignment = .center
    textLabel.adjustsFontSizeToFitWidth = true

    addSubview(imageView)
    addSubview(textLabel)

    contentStackView.addArrangedSubview(imageView)
    contentStackView.addArrangedSubview(textLabel)
    contentStackView.axis = .vertical
    contentStackView.alignment = .center

    addSubview(contentStackView)
    contentStackView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    textLabel.snp.makeConstraints { (make) in
      make.height.equalTo(70)
    }
  }

}
