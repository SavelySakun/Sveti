import Foundation
import Charts

class StatDayContentManager: IStatContentManager {
  typealias T = BarChartDataSet?
  static let shared = StatDayContentManager()
  
  var contentGenerationResult: StatGenerationResult = .success
  var currentlyDrawedStat: [DrawableStat]? = [DrawableStat]()
  var dataSet: BarChartDataSet?
  
  func getStatContent() -> BarChartDataSet? {
    updateStatContent()
    return self.dataSet
  }

  func updateStatContent() {
    let settings = StatSettingsManager.shared

    // Important: we pass content manager into data generator
    let dataGenerator = StatDaysDataSetGenerator(settingsManager: settings, contentManager: self)
    dataGenerator.fillContentManagerWithData()
  }

  func isHasContentToDraw() -> Bool {
    guard let currentlyDrawedStat = currentlyDrawedStat else { return false }
    return !currentlyDrawedStat.isEmpty
  }
}
