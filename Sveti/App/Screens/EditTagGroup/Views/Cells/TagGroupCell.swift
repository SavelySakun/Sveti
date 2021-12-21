import UIKit
import Combine

class TagGroupCell: Cell {

  private var tagId = String()
  private let textFieldContainer = UIView()
  private let tagNameTextField = UITextField()
  private let buttonIconView = ButtonIconView()
  private let editButtonView = RoundButtonView(firstStateImage: "more")

  override func configureSelf(with viewModel: CellVM) {
    guard let tag = viewModel.cellValue as? Tag else { return }
    self.tagId = tag.id
    tagNameTextField.text = tag.name
    tagNameTextField.delegate = self
    tagNameTextField.autocapitalizationType = .none
  }

  override func setLayout() {
    selectionStyle = .none
    setIconButton()
    setTextField()
    setRoundButtons()
    setEditButtonAction()
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
    editButtonView.imageView?.tintColor = .white
    editButtonView.sizeSetupHandler = {
      self.editButtonView.snp.makeConstraints { (make) in
        make.height.width.equalTo(28)
      }
    }
    editButtonView.updateSize()
    editButtonView.backColor = #colorLiteral(red: 0.1764705882, green: 0.6117647059, blue: 0.9882352941, alpha: 1).withAlphaComponent(0.7)
    contentView.addSubview(editButtonView)
    editButtonView.snp.makeConstraints { (make) in
      make.centerY.equalTo(textFieldContainer.snp.centerY)
      make.left.equalTo(textFieldContainer.snp.right).offset(UIUtils.defaultOffset)
      make.right.equalToSuperview().offset(-UIUtils.defaultOffset)
    }
  }

  private func setEditButtonAction() {
    editButtonView.tapAction = {
      guard let editTagsGroupVC = CurrentVC.current as? EditTagGroupVC else { return }
      editTagsGroupVC.showEditAlert(forTag: self.tagId)
    }
  }

  private func sendEvent(with type: TagEditType) {
    let event = TagEvent(type: type, value: tagId)
    publisher.send(event)
    delegate?.onUpdate()
  }
}

extension TagGroupCell: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let newName = textField.text else { return }
    TagsRepository().renameTag(withId: tagId, newName: newName)
  }
}
