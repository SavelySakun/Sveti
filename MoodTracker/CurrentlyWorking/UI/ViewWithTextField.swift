import UIKit

class ViewWithTextField: UIView {

  var textField = UITextView()

  init(placeholder: String) {
    super.init(frame: .zero)
    textField.isEditable = true
    textField.backgroundColor = .systemGray6
    textField.font = UIFont.systemFont(ofSize: 16)
    textField.isScrollEnabled = false

    self.backgroundColor = .systemGray6
    self.layer.cornerRadius = 12
    self.contentMode = .scaleAspectFit
    self.addSubview(textField)

    textField.snp.makeConstraints { (make) in
      make.top.left.equalToSuperview().offset(UIUtils.defaultOffset)
      make.right.bottom.equalToSuperview().offset(-UIUtils.defaultOffset)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
