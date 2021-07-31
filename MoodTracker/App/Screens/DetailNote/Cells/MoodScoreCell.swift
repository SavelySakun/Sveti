import UIKit

class MoodScoreCell: Cell {

  let containerView = UIView()
  let emotionalStateScoreView = ScoreView()
  let physicalStateScoreView = ScoreView(isMiddle: true)
  let willToLiveScoreView = ScoreView()
  let averageLabel = UILabel()
  var statesStackView: UIStackView!

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func configureSelf(with viewModel: CellVM) {
    super.configureSelf(with: viewModel)

    guard let note = viewModel.cellValue as? Note,
          let mood = note.mood else { return }

    let mathHelper = MathHelper()
    emotionalStateScoreView.scoreLabel.text = mathHelper.getMoodScore(from: mood.emotionalState)
    physicalStateScoreView.scoreLabel.text = mathHelper.getMoodScore(from: mood.physicalState)
    willToLiveScoreView.scoreLabel.text = mathHelper.getMoodScore(from: mood.willToLive)
    averageLabel.text = mathHelper.getAverageMood(from: note)
    guard mood.average > 7.0 || mood.average < 5.0 else { return }
    averageLabel.textColor = ColorHelper().getColor(value: Int(mood.average), alpha: 1)
  }

  private func setLayout() {
    addContainer()
    setStateScoresStackView()
    setGlobalStackView()
  }

  private func addContainer() {
    containerView.backgroundColor = .systemGray6
    contentView.addSubview(containerView)
    containerView.snp.makeConstraints { (make) in
      make.top.left.bottom.right.equalToSuperview()
    }
  }

  private func setStateScoresStackView() {
    statesStackView = UIStackView(arrangedSubviews: [
      emotionalStateScoreView,
      physicalStateScoreView,
      willToLiveScoreView
    ])

    physicalStateScoreView.stateLabel.text = "физическое состояние"
    willToLiveScoreView.stateLabel.text = "желание жить, делать дела"

    statesStackView.axis = .vertical
    statesStackView.spacing = 0
  }

  private func setGlobalStackView() {
    averageLabel.text = "9"
    averageLabel.textAlignment = .center
    averageLabel.snp.makeConstraints { (make) in
      make.width.equalTo(45)
    }

    let globalStack = UIStackView(arrangedSubviews: [
      statesStackView,
      averageLabel
    ])

    globalStack.axis = .horizontal
    globalStack.distribution = .fillProportionally

    containerView.addSubview(globalStack)
    globalStack.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(10)
      make.left.equalToSuperview().offset(20)
      make.right.equalToSuperview()
      make.bottom.equalToSuperview().offset(-10)
    }
  }

}
