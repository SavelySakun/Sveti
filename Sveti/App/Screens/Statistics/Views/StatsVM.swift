import Foundation
import RealmSwift

class StatsVM: ViewControllerVM {

  private let statSettingsRepository = StatSettingsRepository()

  init(tableDataProvider: TableDataProvider) {
    super.init(tableDataProvider: tableDataProvider)
    setMaximumDateAsCurrentDay()
  }

  private func setMaximumDateAsCurrentDay() {
    statSettingsRepository.updateMaximumDate(SplitDate(rawDate: Date()).endOfDay)
  }

  override func handle<T>(_ event: T) where T: Event {
    guard let event = event as? StatsFilterEvent else { return }
    let eventType = StatsFilterEventType(rawValue: event.type)

    switch eventType {
    case .selectMinumumDate:
      guard let minimumDate = event.value as? Date else { return }
      statSettingsRepository.updateMinimumDate(SplitDate(rawDate: minimumDate).startOfDay)
      SvetiAnalytics.log(.changeStatDateRange)
    case .selectMaximumDate:
      guard let maximumDate = event.value as? Date else { return }
      statSettingsRepository.updateMaximumDate(SplitDate(rawDate: maximumDate).endOfDay)
      SvetiAnalytics.log(.changeStatDateRange)
    case .changeGrouping:
      guard let groupingType = event.value as? GroupingType else { return }
      statSettingsRepository.updateGrouping(groupingType)
      SvetiAnalytics.log(.changeStatGroupingType)
    case .none:
      return
    }

    guard let statDaysVC = CurrentVC.current as? StatsVC else { return }
    statDaysVC.updateContent()
  }
}
