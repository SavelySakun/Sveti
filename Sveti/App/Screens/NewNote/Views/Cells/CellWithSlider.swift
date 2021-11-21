import UIKit
import SnapKit
import Combine

class CellWithSlider: Cell {

	lazy var titleLabel = getInfoLabel()
  let slider = UISlider()
	lazy var sliderStackView = getSliderStackView()

	override func setLayout() {
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
    slider.tintColor = #colorLiteral(red: 0.1764705882, green: 0.6117647059, blue: 0.9882352941, alpha: 1).withAlphaComponent(0.7)
    slider.maximumTrackTintColor = .white
  }

  @objc func onValueChange() {
    titleLabel.text = getTitle()
  }

  func getTitle() -> String {
    let value = MathHelper().getMoodScore(from: Double(slider.value), digits: 1)
    return "\(viewModel?.title ?? ""): \(value)"
  }
}
