import Foundation

class StatsVM: ViewControllerVM {

  override func handle<T>(_ event: T) where T : Event {
    guard let event = event as? StatsFilterEvent else { return }
    let eventType = StatsFilterEventType(rawValue: event.type)

  }
  
}
