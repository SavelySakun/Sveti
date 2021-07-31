import UIKit
import Combine

class EmotionalStateSliderCell: CellWithSlider {

  override func onValueChange() {
    super.onValueChange()
    let event = EditEvent(type: .emotionalStateChange, value: slider.value)
    publisher.send(event)
  }

}

class PhysicalStateSliderCell: CellWithSlider {

  override func onValueChange() {
    super.onValueChange()
    let event = EditEvent(type: .physicalStateChange, value: slider.value)
    publisher.send(event)
  }

}


class WillToLiveStateSliderCell: CellWithSlider {

  override func onValueChange() {
    super.onValueChange()
    let event = EditEvent(type: .willToLiveChange, value: slider.value)
    publisher.send(event)
  }

}
