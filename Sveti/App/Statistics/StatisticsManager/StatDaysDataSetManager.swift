import Foundation
import Charts

class StatDaysDataSetManager {

  static let shared = StatDaysDataSetManager()
  var currentlyDrawedStatDays: [StatDay]? = [StatDay]()
  var minimumDate = Date()
  var maximumDate = Date()

  private let statDaysRepository = StatDaysRepository()

  func getBarChartDataSet() -> BarChartDataSet? {
    guard let allStatDays = statDaysRepository.getAll() else { return nil }
    let dataEntry = prepateDataEntry(from: allStatDays)
    return BarChartDataSet(entries: dataEntry)
  }

  private func prepateDataEntry(from data: [StatDay]) -> [BarChartDataEntry] {
    let sortedByTimeData = data.sorted {
      guard let date0 = $0.splitDate, let date1 = $1.splitDate else { return false }
      return date0.rawDate.timeIntervalSince1970 < date1.rawDate.timeIntervalSince1970
    }

    let timeRangeFilteredData = sortedByTimeData.filter { statDay in
      guard let splitDate = statDay.splitDate else { return false }
      let minimumDateInterval = minimumDate.timeIntervalSince1970
      let maximumDateInterval = maximumDate.timeIntervalSince1970
      let statDayInterval = splitDate.rawDate.timeIntervalSince1970
      return statDayInterval >= minimumDateInterval && statDayInterval <= maximumDateInterval
    }

    currentlyDrawedStatDays = timeRangeFilteredData
    var dataEntry = [BarChartDataEntry]()

    for (index, statDay) in timeRangeFilteredData.enumerated() {
      let index = Double(index)
      let drawableStatDay = DrawableStatDay(statDay: statDay)
      dataEntry.append(BarChartDataEntry(x: index, y: drawableStatDay.averageState))
    }

    return dataEntry
  }
  
}
