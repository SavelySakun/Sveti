import UIKit

class MoodScoreCell: Cell {

  let containerView = UIView()
  let emotionalStateScoreView = ScoreView(position: .second)
  let physicalStateScoreView = ScoreView(position: .first)
  let averageLabel = UILabel()
  var statesStackView: UIStackView!

  override func configureSelf(with viewModel: CellVM) {
    super.configureSelf(with: viewModel)

    guard let note = viewModel.cellValue as? Note,
          let mood = note.mood else { return }

    let mathHelper = MathHelper()
    emotionalStateScoreView.scoreLabel.text = mathHelper.getMoodScore(from: mood.emotionalState)
    physicalStateScoreView.scoreLabel.text = mathHelper.getMoodScore(from: mood.physicalState)
    averageLabel.text = mathHelper.getAverageMood(from: note)
    averageLabel.textColor = ColorHelper().getColor(value: Int(mood.average), alpha: 1)
  }

  override func setLayout() {
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
      physicalStateScoreView,
      emotionalStateScoreView
    ])

    emotionalStateScoreView.stateLabel.text = "emotional state".localized
    physicalStateScoreView.stateLabel.text = "phyzical state".localized

    statesStackView.axis = .vertical
    statesStackView.spacing = 0
  }

  private func setGlobalStackView() {
    averageLabel.font = UIFont.boldSystemFont(ofSize: 16)
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
      make.top.bottom.equalToSuperview().inset(10)
      make.left.equalToSuperview().offset(20)
      make.right.equalToSuperview()
    }
  }

}
