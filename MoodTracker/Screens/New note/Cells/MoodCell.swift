import UIKit
import SnapKit

class MoodCell: UITableViewCell {

	static let reuseId = "MoodCell"
	lazy var infoLabel = getInfoLabel()
	lazy var moodSlider = getSlider()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setLayout()
	}


	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setContent() {
		infoLabel.text = "Укажи настроение"
	}

	fileprivate func setLayout() {
		let stackView = getStackView()
		contentView.addSubview(stackView)
		let topBottomOffset = 18
		let leftRightOffset = 32
		stackView.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(topBottomOffset)
			make.bottom.equalToSuperview().offset(-topBottomOffset)
			make.right.equalToSuperview().offset(-leftRightOffset)
			make.left.equalToSuperview().offset(leftRightOffset)
		}
	}

	fileprivate func getStackView() -> UIStackView {
		let stackView = UIStackView(arrangedSubviews: [infoLabel, moodSlider])
		stackView.axis = .vertical
		stackView.spacing = 8
		return stackView
	}


	fileprivate func getInfoLabel() -> UILabel {
		let label = UILabel()
		return label
	}

	fileprivate func getSlider() -> UIStackView {
		let slider = UISlider()
		slider.minimumValue = 0
		slider.maximumValue = 100
		slider.value = 50.0

		let minimumLabel = UILabel()
		minimumLabel.text = "0"
		let maximumLabel = UILabel()
		maximumLabel.text = "100"

		let sliderStackView = UIStackView(arrangedSubviews: [minimumLabel, slider, maximumLabel])
		sliderStackView.axis = .horizontal
		sliderStackView.spacing = 12

		return sliderStackView
	}

}
