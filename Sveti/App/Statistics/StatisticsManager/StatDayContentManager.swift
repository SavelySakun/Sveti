import Foundation
import Charts

class StatDayContentManager: IStatContentManager {
  typealias T = BarChartDataSet?
  static let shared = StatDayContentManager()
  
  var contentGenerationResult: StatGenerationResult = .success
  var currentlyDrawedStat: [DrawableStat]? = [DrawableStat]()
  var dataSet: BarChartDataSet?
  
  func getStatContent() -> BarChartDataSet? {
    let settings = StatSettingsManager.shared
    let dataGenerator = StatDaysDataSetGenerator(settingsManager: settings, contentManager: self)
    dataGenerator.generateDataForManager()
    return self.dataSet
  }
}
