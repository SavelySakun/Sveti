import UIKit

class TagSectionHeaderView: UICollectionReusableView {

  private let titleLabel = UILabel()
  static let identifier = "tagSectionHeader"
  private let offset = 16
  private let editButton = RoundButtonView(icon: "edit")
  private let collapseButton = RoundButtonView(icon: "arrow_down")
  private let separatorView = UIView()
  lazy var buttonsStackView = UIStackView(arrangedSubviews: [editButton, collapseButton])

  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func set(with title: String) {
    titleLabel.text = title
  }


  private func setLayout() {
    setLabel()
    setButtons()
    setSeparator()
  }

  private func setLabel() {
    titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    titleLabel.text = "Работа"

    addSubview(titleLabel)
    titleLabel.snp.makeConstraints { (make) in
      make.top.equalToSuperview()
      make.left.equalToSuperview()
      make.bottom.equalToSuperview().offset(-offset)
    }
  }

  private func setButtons() {
    buttonsStackView.axis = .horizontal
    buttonsStackView.spacing = 8

    addSubview(buttonsStackView)
    buttonsStackView.snp.makeConstraints { (make) in
      make.top.equalToSuperview()
      make.right.equalToSuperview()
    }

  }

  private func setSeparator() {
    separatorView.backgroundColor = .systemGray5
    addSubview(separatorView)
    separatorView.snp.makeConstraints { (make) in
      make.height.equalTo(2)
      make.left.equalTo(titleLabel.snp.right).offset(UIUtils.defaultOffset)
      make.centerY.equalTo(buttonsStackView.snp.centerY)
      make.right.equalTo(buttonsStackView.snp.left).offset(-UIUtils.defaultOffset)
    }
  }

}
