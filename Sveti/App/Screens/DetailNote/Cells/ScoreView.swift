import UIKit

enum Position {
  case first
  case second
}

class ScoreView: UIView {

  let stateLabel = UILabel()
  let scoreLabel = UILabel()
  private let separatorColor: UIColor = .systemGray4
  private var scoreStackView: UIStackView!
  private let position: Position

  init(position: Position) {
    self.position = position
    super.init(frame: .zero)
    setLayout()
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setLayout() {
    addHorizontalSeparators()
    setScoreSeparatorsStack()
    addGlobalStackView()
  }

  private func addHorizontalSeparators() {
    let topSeparator = UIView()
    let bottomSeparator = UIView()
    [topSeparator, bottomSeparator].forEach { separator in
      separator.backgroundColor = separatorColor

      addSubview(separator)
      separator.snp.makeConstraints { (make) in
        make.right.equalToSuperview()
        make.left.equalToSuperview()
        make.height.equalTo(1)
      }
    }

    topSeparator.snp.makeConstraints { (make) in
      make.top.equalToSuperview()
    }

    bottomSeparator.snp.makeConstraints { (make) in
      make.bottom.equalToSuperview()
    }

    if position == .first {
      topSeparator.isHidden = true
      bottomSeparator.isHidden = true
    } else {
      bottomSeparator.isHidden = true
    }
  }

  private func setScoreSeparatorsStack() {
    let leftSeparatorView = UIView()
    let rightSeparatorView = UIView()
    scoreLabel.textAlignment = .center

    [leftSeparatorView, rightSeparatorView].forEach { separator in
      separator.backgroundColor = separatorColor
      separator.snp.makeConstraints { (make) in
        make.width.equalTo(1)
      }
    }

    scoreStackView = UIStackView(arrangedSubviews: [
      leftSeparatorView,
      scoreLabel,
      rightSeparatorView
    ])

    scoreLabel.snp.makeConstraints { (make) in
      make.width.equalTo(45)
    }
    scoreStackView.axis = .horizontal
  }

  func addGlobalStackView() {
    stateLabel.textAlignment = .left

    let globalStackView = UIStackView(arrangedSubviews: [
      stateLabel,
      scoreStackView
    ])

    globalStackView.spacing = 10

    addSubview(globalStackView)
    globalStackView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
      make.height.equalTo(45)
    }
  }

}
