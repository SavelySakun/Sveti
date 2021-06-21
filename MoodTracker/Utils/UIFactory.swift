import UIKit

class UIFactory {

  static func getTextField(with placeholder: String) -> UIView {
    let fieldView = UIView()
    fieldView.backgroundColor = .systemGray6
    fieldView.layer.cornerRadius = 12
    fieldView.contentMode = .scaleAspectFit

    let textField = UITextField()
    textField.placeholder = placeholder

    fieldView.addSubview(textField)
    textField.snp.makeConstraints { (make) in
      make.height.equalTo(50)
      make.top.left.equalToSuperview().offset(UIUtils.defaultOffset)
      make.right.bottom.equalToSuperview().offset(-UIUtils.defaultOffset)
    }

    return fieldView
  }

}
