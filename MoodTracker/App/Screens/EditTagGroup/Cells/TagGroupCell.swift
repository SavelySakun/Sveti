import UIKit
import Combine

class TagGroupCell: Cell {

  private let textFieldContainer = UIView()
  private let tagNameTextField = UITextField()
  private let buttonIconView = ButtonIconView()
  private let hideButtonView = RoundButtonView(firstStateImage: "hide")
  private let deleteButtonView = RoundButtonView(firstStateImage: "minus")
  private var tagId = String()

  override func configureSelf(with viewModel: CellVM) {
    guard let tag = viewModel.cellValue as? Tag else { return }
    self.tagId = tag.id
    tagNameTextField.text = tag.name

    if tag.isHidden {
      hideButtonView.imageView.image = UIImage(named: "show")?.withRenderingMode(.alwaysTemplate)
    } else {
      hideButtonView.imageView.image = UIImage(named: "hide")?.withRenderingMode(.alwaysTemplate)
    }
  }

  override func setLayout() {
    selectionStyle = .none
    setIconButton()
    setTextField()
    setRoundButtons()
    setButtonsAction()
  }

  private func setTextField() {
    textFieldContainer.backgroundColor = .systemGray6
    textFieldContainer.layer.cornerRadius = 12
    textFieldContainer.addSubview(tagNameTextField)
    tagNameTextField.snp.makeConstraints { (make) in
      make.top.left.equalToSuperview().offset(UIUtils.defaultOffset)
      make.right.bottom.equalToSuperview().offset(-UIUtils.defaultOffset)
    }

    contentView.addSubview(textFieldContainer)
    textFieldContainer.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(4)
      make.left.equalTo(buttonIconView.snp.right).offset(UIUtils.defaultOffset)
      make.bottom.equalToSuperview().offset(-4)
    }
  }

  private func setIconButton() {
    contentView.addSubview(buttonIconView)
    buttonIconView.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(4)
      make.left.equalToSuperview().offset(UIUtils.middleOffset)
      make.bottom.equalToSuperview().offset(-4)
    }
  }

  private func setRoundButtons() {
    [hideButtonView, deleteButtonView].forEach { button in
      button.imageView.tintColor = .white
      button.sizeSetupHandler = {
        button.snp.makeConstraints { (make) in
          make.height.width.equalTo(24)
        }
      }
      button.updateSize()
    }

    hideButtonView.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.6117647059, blue: 0.9882352941, alpha: 1).withAlphaComponent(0.8)
    deleteButtonView.backgroundColor = .systemRed.withAlphaComponent(0.7)

    let buttonsStackView = UIStackView(arrangedSubviews: [hideButtonView, deleteButtonView])
    buttonsStackView.axis = .horizontal
    buttonsStackView.spacing = 8

    contentView.addSubview(buttonsStackView)
    buttonsStackView.snp.makeConstraints { (make) in
      make.centerY.equalTo(textFieldContainer.snp.centerY)
      make.left.equalTo(textFieldContainer.snp.right).offset(UIUtils.defaultOffset)
      make.right.equalToSuperview().offset(-UIUtils.defaultOffset)
    }
  }

  private func setButtonsAction() {
    hideButtonView.tapAction = {
      self.sendEvent(with: .hide)
    }

    deleteButtonView.tapAction = {
      self.sendEvent(with: .delete)
    }
  }

  private func sendEvent(with type: TagEditType) {
    let event = TagEvent(type: type, value: tagId)
    publisher.send(event)
    delegate?.onUpdate()
  }
}

