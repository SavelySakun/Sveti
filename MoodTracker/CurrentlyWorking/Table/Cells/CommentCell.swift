import UIKit
import Combine

class CommentCell: Cell {
  
  lazy var commentTextField = UIFactory.getTextField(with: "Введи комментарий")

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setLayout()
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

  private func setTextField() {
    //let textFieldPublisher = NotificationCenter.default.publisher(for: \tex.text, object: commentTextField)
  }


}
