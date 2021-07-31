import Foundation
import Combine

enum EditType {
  case emotionalStateChange
  case physicalStateChange
  case willToLiveChange
  case commentChange
  case dateChange
}

struct EditEvent {
  let type: EditType
  let value: Any
}
