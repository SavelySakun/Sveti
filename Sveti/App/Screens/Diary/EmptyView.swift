import UIKit

class EmptyView: UIView {

  private let emptyIconImageView = UIImageView()
  private let emptyLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setLayout() {
    let iconImage = UIImage(named: "gardening")
    emptyIconImageView.image = iconImage
    emptyIconImageView.tintColor = .systemBlue
    emptyIconImageView.contentMode = .scaleAspectFit

    emptyIconImageView.snp.makeConstraints { (make) in
      make.width.equalTo(400)
      make.height.equalTo(300)
    }

    emptyLabel.text = "Add the first note in the \"New Entry\" section"
    emptyLabel.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
    emptyLabel.numberOfLines = 0
    emptyLabel.textAlignment = .center
    emptyLabel.contentMode = .scaleAspectFit

    emptyLabel.snp.makeConstraints { (make) in
      make.width.equalTo(250)
    }

    let stackView = UIStackView(arrangedSubviews: [emptyIconImageView, emptyLabel])
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.alignment = .center

    addSubview(stackView)
    stackView.snp.makeConstraints { (make) in
      make.top.left.bottom.right.equalToSuperview()
    }
  }

}
