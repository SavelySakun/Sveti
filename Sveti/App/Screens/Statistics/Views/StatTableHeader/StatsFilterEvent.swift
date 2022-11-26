import Foundation

enum StatsFilterEventType: String {
    case selectMinumumDate
    case selectMaximumDate
    case changeGrouping
}

class StatsFilterEvent: Event {
    init(type: StatsFilterEventType, value: Any) {
        super.init(type: type.rawValue, value: value)
    }
}
