import UIKit

class ScoreView: UIView {

  let stateLabel = UILabel()
  let scoreLabel = UILabel()
  private let separatorColor: UIColor = .systemGray4
  private let isMiddle: Bool
  private var scoreStackView: UIStackView!

  init(isMiddle: Bool = false) {
    self.isMiddle = isMiddle
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
      separator.isHidden = !isMiddle

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
  }

  private func setScoreSeparatorsStack() {
    let leftSeparatorView = UIView()
    let rightSeparatorView = UIView()
    scoreLabel.text = "7"
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
    stateLabel.text = "эмоциональное состояние"
    stateLabel.textAlignment = .left

    let globalStackView = UIStackView(arrangedSubviews: [
      stateLabel,
      scoreStackView
    ])

    globalStackView.spacing = 10

    addSubview(globalStackView)
    globalStackView.snp.makeConstraints { (make) in
      make.top.equalToSuperview()
      make.left.equalToSuperview()
      make.right.equalToSuperview()
      make.bottom.equalToSuperview()
      make.height.equalTo(45)
    }
  }

}
