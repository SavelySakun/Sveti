import UIKit

class PhysSliderCell: CellWithSlider {

  override func onValueChange() {
    super.onValueChange()
    let event = EditEvent(type: .physChange, value: slider.value)
    publisher.send(event)
  }
  
}
