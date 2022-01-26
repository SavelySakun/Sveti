import UIKit

class TextCollectionCell: UICollectionViewCell {
  static let reuseId = "TextCollectionCell"
  let textLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setTextStyle()
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setTextStyle() {
    textLabel.textColor = .systemGray
  }

  func setLayout() {
    addSubview(textLabel)
    textLabel.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
}
