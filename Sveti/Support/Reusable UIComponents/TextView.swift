import Combine
import UIKit

class TextView: UIView {
    var textView = UITextView()
    let placeholderLabel = UILabel()
    private var cancellable: AnyCancellable?

    init(placeholder: String) {
        super.init(frame: .zero)
        textView.isEditable = true
        textView.backgroundColor = .systemGray6
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = false

        backgroundColor = .systemGray6
        layer.cornerRadius = 12
        contentMode = .scaleAspectFit

        setTextField()
        setPlaceholder(placeholder)
    }

    private func setTextField() {
        addNotificationToTextView()
        addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.right.bottom.equalToSuperview()
        }
    }

    private func setPlaceholder(_ text: String) {
        placeholderLabel.text = text
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !textView.text.isEmpty

        addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIUtils.defaultOffset)
            make.left.equalToSuperview().offset(5)
            make.right.bottom.equalToSuperview().offset(-UIUtils.defaultOffset)
        }
    }

    private func addNotificationToTextView() {
        let publisher = NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification, object: textView)
        cancellable = publisher.sink { notification in
            guard let textView = notification.object as? UITextView else { return }
            self.placeholderLabel.isHidden = !textView.text.isEmpty
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
