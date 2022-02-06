import Foundation

enum NoteEditType: String {
  case emotionalStateChange
  case physicalStateChange
  case commentChange
  case dateChange
  case tagChange
  case needUpdate
}

class EditEvent: Event {
  init(type: NoteEditType, value: Any) {
    super.init(type: type.rawValue, value: value)
  }
}
