import Foundation
import Combine

enum EditType {
  case moodChange
  case physChange
  case commentChange
  case dateChange
}

struct EditEvent {
  let type: EditType
  let value: Any
}
