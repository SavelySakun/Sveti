import Combine
import UIKit

class EmotionalStateSliderCell: CellWithSlider {
    override func onValueChange() {
        super.onValueChange()
        let event = EditEvent(type: .emotionalStateChange, value: Double(slider.value))
        publisher.send(event)
    }

    override func configureSelf(with viewModel: CellVM) {
        super.configureSelf(with: viewModel)
        accessibilityIdentifier = "emotional-cell"
        guard let note = viewModel.cellValue as? Note else { return }
        slider.value = Float(note.mood?.emotionalState ?? 6.0)
        titleLabel.attributedText = getTitle()
    }
}

class PhysicalStateSliderCell: CellWithSlider {
    override func onValueChange() {
        super.onValueChange()
        let event = EditEvent(type: .physicalStateChange, value: Double(slider.value))
        publisher.send(event)
    }

    override func configureSelf(with viewModel: CellVM) {
        super.configureSelf(with: viewModel)
        accessibilityIdentifier = "physical-cell"
        guard let note = viewModel.cellValue as? Note else { return }
        slider.value = Float(note.mood?.physicalState ?? 6.0)
        titleLabel.attributedText = getTitle()
    }
}
