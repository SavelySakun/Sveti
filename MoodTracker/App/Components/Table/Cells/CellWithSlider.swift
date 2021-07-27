import UIKit
import SnapKit
import Combine

class CellWithSlider: Cell {
  
	lazy var titleLabel = getInfoLabel()
  let slider = UISlider()
	lazy var sliderStackView = getSliderStackView()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		setLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	fileprivate func setLayout() {
    contentView.backgroundColor = .systemGray6
		let stackView = getStackView()
		contentView.addSubview(stackView)
		let topBottomOffset = 18
		stackView.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(topBottomOffset)
			make.bottom.equalToSuperview().offset(-topBottomOffset)
			make.right.equalToSuperview().offset(-topBottomOffset)
			make.left.equalToSuperview().offset(topBottomOffset)
		}
	}

	fileprivate func getStackView() -> UIStackView {
		let stackView = UIStackView(arrangedSubviews: [titleLabel, sliderStackView])
		stackView.axis = .vertical
		stackView.spacing = 8
		return stackView
	}

	fileprivate func getInfoLabel() -> UILabel {
		let label = UILabel()
		return label
	}

	fileprivate func getSliderStackView() -> UIStackView {
		slider.minimumValue = 0
		slider.maximumValue = 10
    slider.addTarget(self, action: #selector(onValueChange), for: .allEvents)

		let minimumLabel = UILabel()
		minimumLabel.text = "0"
		let maximumLabel = UILabel()
		maximumLabel.text = "10"

		let sliderStackView = UIStackView(arrangedSubviews: [minimumLabel, slider, maximumLabel])
		sliderStackView.axis = .horizontal
		sliderStackView.spacing = 12

		return sliderStackView
	}

  override func configureSelf(with viewModel: CellVM) {
    super.configureSelf(with: viewModel)
    slider.value = viewModel.cellValue as? Float ?? 6.0
    titleLabel.text = getTitle()
    updateSliderColor()
  }

  @objc func onValueChange() {
    titleLabel.text = getTitle()
    updateSliderColor()
  }

  private func getTitle() -> String {
    let formatedValue = String(format: "%.0f", slider.value)
    return "\(viewModel?.title ?? ""): \(formatedValue)"
  }

  private func updateSliderColor() {
    let sliderValue = Int(slider.value)
    slider.tintColor = ColorHelper().getColor(value: sliderValue)
  }

}
