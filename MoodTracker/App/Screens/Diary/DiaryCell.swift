import UIKit

class DiaryCell: Cell {

  let scoreTimeView = ScoreTimeView()
  let commentLabel = UILabel()
  let containerView = UIView()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setLayout()

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  private func setLayout() {
    self.selectionStyle = .none
    setContainer()
    setScoreTime()
    setComment()
  }

  private func setContainer() {
    contentView.addSubview(containerView)
    containerView.layer.cornerRadius = 22
    containerView.backgroundColor = .systemGray6
    containerView.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(6)
      make.left.equalToSuperview().offset(15)
      make.right.equalToSuperview().offset(-15)
      make.bottom.equalToSuperview().offset(-6)
    }
  }

  private func setScoreTime() {
    containerView.addSubview(scoreTimeView)
    scoreTimeView.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(UIUtils.middleOffset)
      make.left.equalToSuperview().offset(UIUtils.middleOffset)
    }
  }

  private func setComment() {
    commentLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    commentLabel.numberOfLines = 3
    commentLabel.text = "Таким образом постоянный количественный рост и сфера нашей активности обеспечивает. Таким образом постоянный количественный рост и сфера нашей активности обеспечивает."

    containerView.addSubview(commentLabel)
    commentLabel.snp.makeConstraints { (make) in
      make.top.equalTo(scoreTimeView.snp.bottom).offset(8)
      make.left.equalToSuperview().offset(UIUtils.middleOffset)
      make.right.equalToSuperview().offset(-UIUtils.middleOffset)
      make.bottom.equalToSuperview().offset(-UIUtils.middleOffset)
    }
  }
}
