import Foundation

enum StatsFilterEventType: String {
  case selectStartDate
  case selectEndDate
  case changeGrouping
}

class StatsFilterEvent: Event {
  init(type: StatsFilterEventType, value: Any) {
    super.init(type: type.rawValue, value: value)
  }
}
