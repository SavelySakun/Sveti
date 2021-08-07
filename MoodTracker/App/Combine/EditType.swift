import Foundation
import Combine

enum EditType {
  case emotionalStateChange
  case physicalStateChange
  case willToLiveChange
  case commentChange
  case dateChange
  case tagChange
}

struct EditEvent {
  let type: EditType
  let value: Any
}
