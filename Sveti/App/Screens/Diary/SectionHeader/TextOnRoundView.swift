import UIKit

class TextOnRoundView: UIView {

  let textLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setLayout() {
    setBackground()
    addScore()
  }

  private func setBackground() {
    self.backgroundColor = .systemGray5
    self.layer.cornerRadius = 6.5
  }

  private func addScore() {
    addSubview(textLabel)
    textLabel.snp.makeConstraints { (make) in
      make.top.bottom.equalToSuperview().inset(5)
      make.left.right.equalToSuperview().inset(10)
    }
  }

}
