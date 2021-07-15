import UIKit

class MoodSliderCell: CellWithSlider {

  override func onValueChange() {
    super.onValueChange()
    let event = EditEvent(type: .moodChange, value: slider.value)
    publisher.send(event)
  }

}
