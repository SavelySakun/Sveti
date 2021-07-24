import UIKit
import Combine

class CommentCell: Cell {
  
  lazy var commentTextField = ViewWithTextField(placeholder: "Идеи, мысли, замечания...")

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setLayout()
    commentTextField.textField.delegate = self
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setLayout() {
		contentView.addSubview(commentTextField)
		commentTextField.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(UIUtils.defaultOffset)
			make.left.equalToSuperview().offset(UIUtils.defaultOffset)
			make.right.equalToSuperview().offset(-UIUtils.defaultOffset)
      make.bottom.equalToSuperview().offset(-UIUtils.defaultOffset)
		}
	}

}

extension CommentCell: UITextViewDelegate {

  func textViewDidChange(_ textView: UITextView) {
    let event = EditEvent(type: .commentChange, value: textView.text as Any)
    publisher.send(event)
  }

}
