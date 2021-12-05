import UIKit

class DiaryTableSectionHeader: UIView {

  private let dateLabel = UILabel()
  private let separator = UIView()
  private let averageScoreView = TextOnRoundView()
  private lazy var timeWithScoreStack = UIStackView(arrangedSubviews: [dateLabel, averageScoreView])


  init(date: String, averageScore: String? = nil) {
    super.init(frame: .zero)
    setLayout()
    dateLabel.text = date

    averageScoreView.isHidden = (averageScore == nil)
    averageScoreView.textLabel.text = averageScore
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setLayout() {
    backgroundColor = .systemGray6
    setDateLabel()
    setDateAndAverageScore()
    setSeparator()
  }

  private func setDateLabel() {
    dateLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    dateLabel.textColor = .black.withAlphaComponent(0.9)
  }

  private func setSeparator() {
    separator.backgroundColor = .systemGray4
    addSubview(separator)
    separator.snp.makeConstraints { (make) in
      make.centerY.equalTo(timeWithScoreStack.snp.centerY)
      make.left.equalTo(timeWithScoreStack.snp.right).offset(UIUtils.defaultOffset)
      make.right.equalToSuperview()
      make.height.equalTo(1)
    }
  }

  private func setDateAndAverageScore() {
    timeWithScoreStack.axis = .horizontal
    timeWithScoreStack.spacing = 10
    addSubview(timeWithScoreStack)
    timeWithScoreStack.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(10)
      make.left.equalToSuperview().offset(30)
      make.bottom.equalToSuperview().offset(-10)
    }
  }

}
