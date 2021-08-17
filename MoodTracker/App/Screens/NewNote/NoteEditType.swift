import Foundation
import Combine

enum NoteEditType: String {
  case emotionalStateChange
  case physicalStateChange
  case willToLiveChange
  case commentChange
  case dateChange
  case tagChange
}

class EditEvent: Event {
  init(type: NoteEditType, value: Any) {
    super.init(type: type.rawValue, value: value)
  }
}
