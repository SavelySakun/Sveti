import UIKit

class DiaryTableSectionHeader: UIView {

  let dateLabel = UILabel()
  let separator = UIView()

  init(date: String) {
    super.init(frame: .zero)
    setLayout()
    dateLabel.text = date
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setLayout() {
    backgroundColor = .white
    setDateLabel()
    setSeparator()
  }

  private func setDateLabel() {
    dateLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    dateLabel.tintColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
    addSubview(dateLabel)
    dateLabel.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(10)
      make.left.equalToSuperview().offset(30)
      make.bottom.equalToSuperview().offset(-10)
    }
  }

  private func setSeparator() {
    separator.backgroundColor = .systemGray5
    addSubview(separator)
    separator.snp.makeConstraints { (make) in
      make.centerY.equalTo(dateLabel.snp.centerY)
      make.left.equalTo(dateLabel.snp.right).offset(8)
      make.right.equalToSuperview()
      make.height.equalTo(1)
    }
  }

}
