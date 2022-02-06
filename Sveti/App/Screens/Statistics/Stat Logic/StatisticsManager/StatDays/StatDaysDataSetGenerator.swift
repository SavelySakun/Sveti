import Foundation
import Charts

class StatDaysDataSetGenerator {
  private let settings: StatSettings
  private let contentManager: StatDayContentManager

  init(statSettings: StatSettings, contentManager: StatDayContentManager) {
    self.settings = statSettings
    self.contentManager = contentManager
  }

  private let statDaysRepository = StatDaysRepository()
  private lazy var instruments = StatDaysInstruments(with: settings)

  /// Generate content for days average mood bar chart.
  func fillContentManagerWithData() {
    guard let allStatDays = statDaysRepository.getAll(), !allStatDays.isEmpty else {
      contentManager.currentlyDrawedStat = nil
      contentManager.dataSet = nil
      contentManager.contentGenerationResult = .noDataAtAll
      return
    }
    let dataEntry = prepateDataEntry(from: allStatDays)

    // Fills content manager with dataset
    contentManager.dataSet = BarChartDataSet(entries: dataEntry)
  }

  private func prepateDataEntry(from data: [StatDay]) -> [BarChartDataEntry] {
    let timeRangeFilteredData = instruments.filterByTimeRange(data: data)
    let grouped = instruments.group(data: timeRangeFilteredData)
    let drawableStats = generateDrawableStat(groupedData: grouped)
    let orderedByDateStats = instruments.orderByDate(data: drawableStats)

    contentManager.currentlyDrawedStat = orderedByDateStats

    var dataEntry = [BarChartDataEntry]()

    for (index, drawableStat) in orderedByDateStats.enumerated() {
      let index = Double(index)
      dataEntry.append(BarChartDataEntry(x: index, y: drawableStat.averageMood.get(settings.statType)))
    }

    contentManager.contentGenerationResult = dataEntry.isEmpty ? .noDataInTimeRange : .success
    return dataEntry
  }

  private func generateDrawableStat(groupedData: [Date: [StatDay]]) -> [DrawableStat] {
    var drawableStats = [DrawableStat]()
    groupedData.forEach { date, statDays in
      drawableStats.append(DrawableStat(statDays, date))
    }
    return drawableStats
  }
}
