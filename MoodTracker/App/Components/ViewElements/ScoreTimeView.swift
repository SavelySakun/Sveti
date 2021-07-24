import UIKit

class ScoreTimeView: UIView {

  let scoreLabel = UILabel()
  let timeLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setLayout() {
    setLabelsStyle()
    setLabelsLayout()
  }

  private func setLabelsStyle() {
    scoreLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    scoreLabel.textColor = .blue
    timeLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)

    // test
    scoreLabel.text = "8.1"
    timeLabel.text = "в 17:00"
  }

  private func setLabelsLayout() {
    let stackView = UIStackView(arrangedSubviews: [scoreLabel, timeLabel])
    stackView.axis = .horizontal
    stackView.alignment = .firstBaseline
    stackView.spacing = 6

    addSubview(stackView)
    stackView.snp.makeConstraints { (make) in
      make.top.left.right.bottom.equalToSuperview()
    }
  }

}
