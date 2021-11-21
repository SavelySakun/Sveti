import Foundation

enum TagEditType: String {
  case delete
  case hide
  case show
}

class TagEvent: Event {
  init(type: TagEditType, value: Any) {
    super.init(type: type.rawValue, value: value)
  }
}
