import UIKit
import SnapKit

protocol TagSectionHeaderViewDelegate: AnyObject {
  func onCollapseButtonTap(in section: Int)
  func onDoneTagGroupEdit()
}

class TagSectionHeaderView: UICollectionReusableView {

  var section: Int = 0
  private let titleLabel = UILabel()
  static let identifier = "tagSectionHeader"
  private let offset = 16
  private let editButton = RoundButtonView(firstStateImage: "edit")
  private let collapseButton = RoundButtonView(firstStateImage: "arrow_down", secondStateImage: "arrow_up")
  private let separatorView = UIView()
  lazy var buttonsStackView = UIStackView(arrangedSubviews: [editButton, collapseButton])

  var searchModeConstraint: Constraint?
  var defaultConstraint: Constraint?

  weak var delegate: TagSectionHeaderViewDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func set(with title: String, isExpanded: Bool, isSearchMode: Bool) {
    titleLabel.text = title
    collapseButton.setStateImage(isExpanded: isExpanded)

    DispatchQueue.main.async { [self] in
      isSearchMode ? setButtonsHiddenMode() : setDefaultButtons()
    }
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
    setButtonsAction()

    buttonsStackView.contentMode = .scaleAspectFit
    buttonsStackView.axis = .horizontal
    buttonsStackView.spacing = 8

    addSubview(buttonsStackView)
    buttonsStackView.snp.makeConstraints { (make) in
      make.top.equalToSuperview()
      make.right.equalToSuperview()
    }
  }

  private func setButtonsAction() {
    editButton.tapAction = {
      self.onEditTap()
    }

    collapseButton.tapAction = {
      self.onCollapseTap()
    }
  }

  private func setSeparator() {
    separatorView.backgroundColor = .systemGray5
    addSubview(separatorView)
    separatorView.snp.makeConstraints { (make) in
      make.height.equalTo(2)
      make.left.equalTo(titleLabel.snp.right).offset(UIUtils.defaultOffset)
      make.centerY.equalTo(buttonsStackView.snp.centerY)

      defaultConstraint = make.right.equalTo(buttonsStackView.snp.left).offset(-UIUtils.defaultOffset).constraint
      searchModeConstraint = make.right.right.equalToSuperview().constraint
    }
  }

  private func setButtonsHiddenMode() {
    buttonsStackView.isHidden = true
    defaultConstraint?.deactivate()
    searchModeConstraint?.activate()
  }

  private func setDefaultButtons() {
    buttonsStackView.isHidden = false
    searchModeConstraint?.deactivate()
    defaultConstraint?.activate()
  }

  @objc func onCollapseTap() {
    delegate?.onCollapseButtonTap(in: section)
  }

  @objc func onEditTap() {
    let groupId = TagsRepository().findGroupId(with: section)
    let editTagGroupVC = EditTagGroupVC(groupId: groupId)
    editTagGroupVC.onClosingCompletion = {
      self.delegate?.onDoneTagGroupEdit()
    }
    NavigationHelper.push(vc: editTagGroupVC)
  }
}
