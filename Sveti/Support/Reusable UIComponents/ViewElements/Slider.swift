import UIKit

class Slider: UISlider {
  @objc private func sliderTapped(touch: UITouch) {
    let point = touch.location(in: self)
    let percentage = Float(point.x / self.bounds.width)
    let delta = percentage * (self.maximumValue - self.minimumValue)
    let newValue = self.minimumValue + delta
    if newValue != self.value {
      value = newValue
      sendActions(for: .valueChanged)
    }
  }

  override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    sliderTapped(touch: touch)
    return true
  }
}
