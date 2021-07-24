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
    let colors = [#colorLiteral(red: 0.6823529412, green: 0, blue: 0.07843137255, alpha: 1), #colorLiteral(red: 0.7098039216, green: 0.1843137255, blue: 0, alpha: 1), #colorLiteral(red: 0.7176470588, green: 0.2980392157, blue: 0, alpha: 1), #colorLiteral(red: 0.7098039216, green: 0.3960784314, blue: 0, alpha: 1), #colorLiteral(red: 0.6862745098, green: 0.4862745098, blue: 0, alpha: 1), #colorLiteral(red: 0.6470588235, green: 0.5725490196, blue: 0, alpha: 1), #colorLiteral(red: 0.5882352941, green: 0.6588235294, blue: 0, alpha: 1), #colorLiteral(red: 0.5019607843, green: 0.7411764706, blue: 0, alpha: 1), #colorLiteral(red: 0.3764705882, green: 0.8196078431, blue: 0.1333333333, alpha: 1), #colorLiteral(red: 0.3764705882, green: 0.8196078431, blue: 0.1333333333, alpha: 1), #colorLiteral(red: 0.03529411765, green: 0.8941176471, blue: 0.3294117647, alpha: 1)]
    slider.tintColor = colors[Int(slider.value)]
  }

}
