import UIKit
import Combine

class CommentCell: Cell {
  
  lazy var commentTextField = TextView(placeholder: "Идеи, мысли, замечания...")

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setLayout()
    commentTextField.textView.delegate = self
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

  override func configureSelf(with viewModel: CellVM) {
    super.configureSelf(with: viewModel)
    updateTextView()
  }

  private func updateTextView() {
    let viewModelValue = viewModel?.cellValue as? String
    if viewModelValue == nil {
      commentTextField.textView.text = String()
      commentTextField.placeholderLabel.isHidden = false
    } else {
      commentTextField.textView.text = viewModelValue
    }
  }

	private func setLayout() {
    contentView.backgroundColor = .systemGray6
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
    delegate?.onUpdate()
  }

}
