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

  /// Generate content for days average mood bar chart.
  func fillContentManagerWithData() {
    guard let allStatDays = statDaysRepository.getAll(), !allStatDays.isEmpty else {
      contentManager.contentGenerationResult = .noDataAtAll
      return
    }
    let dataEntry = prepateDataEntry(from: allStatDays)

    // Fills content manager with dataset
    contentManager.dataSet = BarChartDataSet(entries: dataEntry)
  }

  private func prepateDataEntry(from data: [StatDay]) -> [BarChartDataEntry] {
    let timeRangeFilteredData = filterByTimeRange(data: data)
    let grouped = group(data: timeRangeFilteredData)
    let drawableStats = generateDrawableStat(groupedData: grouped)
    let orderedByDateStats = orderByDate(data: drawableStats)

    contentManager.currentlyDrawedStat = orderedByDateStats
    var dataEntry = [BarChartDataEntry]()

    for (index, drawableStat) in orderedByDateStats.enumerated() {
      let index = Double(index)
      dataEntry.append(BarChartDataEntry(x: index, y: drawableStat.getAverage(with: settings.statType)))
    }

    contentManager.contentGenerationResult = dataEntry.isEmpty ? .noDataInTimeRange : .success
    return dataEntry
  }

  private func orderByDate(data: [DrawableStat]) -> [DrawableStat] {
    let sortedByTimeData = data.sorted {
      let date0 = $0.splitDate
      let date1 = $1.splitDate
      return date0.rawDate.timeIntervalSince1970 < date1.rawDate.timeIntervalSince1970
    }
    return sortedByTimeData
  }

  private func filterByTimeRange(data: [StatDay]) -> [StatDay] {
    let timeRangeFilteredData = data.filter { statDay in
      guard let splitDate = statDay.splitDate else { return false }
      let minimumDateInterval = settings.minimumDate.timeIntervalSince1970
      let maximumDateInterval = settings.maximumDate.timeIntervalSince1970
      let statDayInterval = splitDate.rawDate.timeIntervalSince1970
      return statDayInterval >= minimumDateInterval && statDayInterval <= maximumDateInterval
    }
    return timeRangeFilteredData
  }

  private func group(data: [StatDay]) -> [Date: [StatDay]] {
    switch settings.groupingType {
    case .day:
      return data.groupedBy(dateComponents: [.year, .month, .day])
    case .week:
      return data.groupedBy(dateComponents: [.yearForWeekOfYear, .weekOfMonth, .weekOfYear])
    case .month:
      return data.groupedBy(dateComponents: [.year, .month])
    case .year:
      return data.groupedBy(dateComponents: [.year])
    }
  }

  private func generateDrawableStat(groupedData: [Date: [StatDay]]) -> [DrawableStat] {
    var drawableStats = [DrawableStat]()
    groupedData.forEach { date, statDays in
      drawableStats.append(DrawableStat(statDays, date))
    }
    return drawableStats
  }
}
