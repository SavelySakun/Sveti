import UIKit

class NoTagsInGroupCell: UICollectionViewCell {
  static let reuseId = "NoTagsInGroupCell"
  let noTagsLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setLayout() {
    noTagsLabel.text = "No active tags"
    noTagsLabel.textColor = .systemGray
    addSubview(noTagsLabel)
    noTagsLabel.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
}
