import UIKit
import Combine

class TextView: UIView {

  var textView = UITextView()
  private let placeholderLabel = UILabel()
  private var cancellable: AnyCancellable?

  init(placeholder: String) {
    super.init(frame: .zero)
    textView.isEditable = true
    textView.backgroundColor = .systemGray6
    textView.font = UIFont.systemFont(ofSize: 16)
    textView.isScrollEnabled = false

    self.backgroundColor = .systemGray6
    self.layer.cornerRadius = 12
    self.contentMode = .scaleAspectFit

    setTextField()
    setPlaceholder(placeholder)
  }

  private func setTextField() {
    addNotificationToTextView()
    self.addSubview(textView)
    textView.snp.makeConstraints { (make) in
      make.top.left.equalToSuperview().offset(UIUtils.defaultOffset)
      make.right.bottom.equalToSuperview().offset(-UIUtils.defaultOffset)
    }
  }

  private func setPlaceholder(_ text: String) {
    placeholderLabel.text = text
    placeholderLabel.textColor = UIColor.lightGray
    placeholderLabel.isHidden = !textView.text.isEmpty

    self.addSubview(placeholderLabel)
    placeholderLabel.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(UIUtils.defaultOffset)
      make.left.equalToSuperview().offset(UIUtils.defaultOffset + 4)
      make.right.bottom.equalToSuperview().offset(-UIUtils.defaultOffset)
    }
  }

  private func addNotificationToTextView() {
    let publisher = NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification, object: textView)
    self.cancellable = publisher.sink { notification in
      guard let textView = notification.object as? UITextView else { return }
      self.placeholderLabel.isHidden = !textView.text.isEmpty
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
