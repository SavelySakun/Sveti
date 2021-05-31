import UIKit

class CommentCell: TableViewCell {

	static let reuseId = "CommentCell"
	lazy var commentTextField = getTextField()
	let viewModel: CellVM = MoodCellVM()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	fileprivate func setLayout() {

		let imageViewsStack = getImageViewsStack()
		let offset = 12

		contentView.addSubview(commentTextField)
		contentView.addSubview(imageViewsStack)

		commentTextField.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(offset)
			make.left.equalToSuperview().offset(offset)
			make.right.equalToSuperview().offset(-offset)
		}

		imageViewsStack.snp.makeConstraints { (make) in
			make.top.equalTo(commentTextField.snp.bottom).offset(offset)
			make.left.equalToSuperview().offset(offset)
			//make.right.equalToSuperview().offset(-offset)
			make.bottom.equalToSuperview().offset(-offset)
		}

	}

	fileprivate func getTextField() -> UIView {
		let fieldView = UIView()
		fieldView.backgroundColor = .systemGray6
		fieldView.layer.cornerRadius = 12
		fieldView.contentMode = .scaleAspectFit

		let textField = UITextField()
		let offset = 12

		fieldView.addSubview(textField)
		textField.snp.makeConstraints { (make) in
			
			make.height.equalTo(70)
			make.top.left.equalToSuperview().offset(offset)
			make.right.bottom.equalToSuperview().offset(-offset)
		}

		return fieldView
	}

	fileprivate func getImageViewsStack() -> UIStackView {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 12

		for _ in 0...3 {
			stackView.addArrangedSubview(getImageView())
		}

		stackView.alignment = .leading

		return stackView
	}

	fileprivate func getImageView() -> UIImageView {
		let imageView = UIImageView()
		imageView.layer.cornerRadius = 10
		imageView.backgroundColor = .lightGray
		imageView.contentMode = .scaleAspectFit

		imageView.snp.makeConstraints { (make) in
			make.width.height.equalTo(45)
		}
		return imageView
	}

}
