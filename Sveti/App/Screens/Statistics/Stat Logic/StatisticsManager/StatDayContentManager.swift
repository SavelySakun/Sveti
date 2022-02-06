import Foundation
import Charts

class StatDayContentManager: IStatContentManager {
  typealias T = BarChartDataSet?
  private let settings = StatSettingsRepository().settings
  static let shared = StatDayContentManager()

  var contentGenerationResult: StatGenerationResult = .success
  var currentlyDrawedStat: [DrawableStat]? = [DrawableStat]()
  var needUpdateViews = false
  var dataSet: BarChartDataSet? {
    didSet {
      self.needUpdateViews = (dataSet?.entries != oldValue?.entries)
    }
  }

  func getStatContent() -> BarChartDataSet? {
    return self.dataSet
  }

  func updateStatContent(onCompletion: (() -> Void)? = nil) {
    // Important: we pass content manager into data generator
    let dataGenerator = StatDaysDataSetGenerator(statSettings: settings, contentManager: self)
    dataGenerator.fillContentManagerWithData()
    onCompletion?()
  }

  func isHasContentToDraw() -> Bool {
    guard let currentlyDrawedStat = currentlyDrawedStat else { return false }
    return !currentlyDrawedStat.isEmpty
  }
}
