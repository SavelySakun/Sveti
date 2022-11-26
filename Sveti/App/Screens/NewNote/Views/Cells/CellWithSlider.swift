import Combine
import SnapKit
import UIKit

class CellWithSlider: Cell {
    lazy var titleLabel = getInfoLabel()
    let slider = Slider()
    lazy var sliderStackView = getSliderStackView()

    override func setLayout() {
        setSeparatorLine()
        contentView.backgroundColor = .systemGray6
        let stackView = getStackView()
        contentView.addSubview(stackView)
        let topBottomOffset = 18
        stackView.snp.makeConstraints { make in
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
        slider.addTarget(self, action: #selector(onValueSelected), for: .touchDown)

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
        let sliderValue = viewModel.cellValue as? Float ?? 6.0
        slider.value = sliderValue
        titleLabel.attributedText = getTitle()
        updateContent()
    }

    @objc func onValueChange() {
        updateContent()
    }

    private func updateContent() {
        DispatchQueue.main.async {
            self.titleLabel.attributedText = self.getTitle()
            self.slider.tintColor = ColorHelper().getColor(value: Int(self.slider.value), alpha: 0.8, palette: .tag)
        }
    }

    @objc func onValueSelected() {
        UISelectionFeedbackGenerator().selectionChanged()
    }

    func getTitle() -> NSAttributedString {
        let value = SvetiMath().getString(from: Double(slider.value), digits: 1)
        let titleText = "\(viewModel?.title ?? ""): "
        let boldText = value
        let attributedString = NSMutableAttributedString(string: titleText)
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]
        let boldString = NSMutableAttributedString(string: boldText, attributes: attributes)
        attributedString.append(boldString)
        return attributedString
    }
}
