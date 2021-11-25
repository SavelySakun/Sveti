import UIKit

class AverageScoreView: UIView {

  let scoreLabel = UILabel()

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
    addSubview(scoreLabel)
    scoreLabel.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(5)
      make.left.equalToSuperview().offset(10)
      make.bottom.equalToSuperview().offset(-5)
      make.right.equalToSuperview().offset(-10)
    }
  }

}
