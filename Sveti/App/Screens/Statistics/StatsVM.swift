import Foundation

class StatsVM: ViewControllerVM {

  override func handle<T>(_ event: T) where T : Event {
    guard let event = event as? StatsFilterEvent else { return }
    let eventType = StatsFilterEventType(rawValue: event.type)

    switch eventType {
    case .selectMinumumDate:
      guard let minimumDate = event.value as? Date else { return }
      StatDaysDataSetManager.shared.minimumDate = minimumDate
    case .selectMaximumDate:
      guard let maximumDate = event.value as? Date else { return }
      StatDaysDataSetManager.shared.maximumDate = maximumDate
    case .changeGrouping:
      guard let groupingType = event.value as? GroupingType else { return }
      StatDaysDataSetManager.shared.groupingType = groupingType
    case .none:
      return
    }

    guard let statDaysVC = CurrentVC.current as? StatsVC else { return }
    statDaysVC.updateContent()
  }
  
}
