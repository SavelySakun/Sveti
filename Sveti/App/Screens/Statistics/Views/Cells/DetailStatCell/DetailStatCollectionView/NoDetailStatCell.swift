import UIKit

class NoDetailStatCell: TextCollectionCell {

  override func setTextStyle() {
    textLabel.text = "No data found 😵‍💫".localized
    textLabel.textColor = .systemGray2
    textLabel.font = UIFont.systemFont(ofSize: 14)
  }

  override func setLayout() {
    layer.cornerRadius = 8
    backgroundColor = .white
    addSubview(textLabel)
    textLabel.snp.makeConstraints { (make) in
      make.edges.equalToSuperview().inset(UIUtils.defaultOffset)
    }
  }

}
