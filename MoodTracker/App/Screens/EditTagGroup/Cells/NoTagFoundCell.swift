import UIKit

class NoTagFound: Cell {

  override func setLayout() {
    let nothingFoundLabel = UILabel()
    nothingFoundLabel.textColor = .lightGray
    nothingFoundLabel.text = "Нет активных тегов 🤨"
    addSubview(nothingFoundLabel)
    nothingFoundLabel.snp.makeConstraints { (make) in
      make.centerY.equalToSuperview()
      make.left.equalToSuperview().offset(UIUtils.bigOffset)
    }
  }
}
