import UIKit

class Slider: UISlider {
    @objc private func sliderTapped(touch: UITouch) {
        let point = touch.location(in: self)
        let percentage = Float(point.x / bounds.width)
        let delta = percentage * (maximumValue - minimumValue)
        let newValue = minimumValue + delta
        if newValue != value {
            value = newValue
            sendActions(for: .valueChanged)
        }
    }

    override func beginTracking(_ touch: UITouch, with _: UIEvent?) -> Bool {
        sliderTapped(touch: touch)
        return true
    }
}
