import Foundation
import RealmSwift

class StatsVM: ViewControllerVM {

  private let realm = try! Realm()

  init(tableDataProvider: TableDataProvider) {
    super.init(tableDataProvider: tableDataProvider)
    setMaximumDateAsCurrentDay()
  }

  private func setMaximumDateAsCurrentDay() {
    try! realm.write {
      StatSettingsManager.shared.settings.maximumDate = SplitDate(rawDate: Date()).endOfDay
    }
  }

  override func handle<T>(_ event: T) where T : Event {
    guard let event = event as? StatsFilterEvent else { return }
    let eventType = StatsFilterEventType(rawValue: event.type)
    let statSettings = StatSettingsManager.shared.settings

    try! realm.write {
      switch eventType {
      case .selectMinumumDate:
        guard let minimumDate = event.value as? Date else { return }
        statSettings.minimumDate = SplitDate(rawDate: minimumDate).startOfDay
      case .selectMaximumDate:
        guard let maximumDate = event.value as? Date else { return }
        statSettings.maximumDate = SplitDate(rawDate: maximumDate).endOfDay
      case .changeGrouping:
        guard let groupingType = event.value as? GroupingType else { return }
        statSettings.groupingType = groupingType
      case .none:
        return
      }
    }

    guard let statDaysVC = CurrentVC.current as? StatsVC else { return }
    statDaysVC.updateContent()
  }
  
}
