import Foundation
import Charts

class StatDaysDataSetManager {

  static let shared = StatDaysDataSetManager()
  var currentlyDrawedStatDays: [StatDay]? = [StatDay]()

  private let statDaysRepository = StatDaysRepository()

  /// Get all available data.
  func getAllOrderedByDay() -> BarChartDataSet? {

    guard let allStatDays = statDaysRepository.getAll() else { return nil }

    let dataEntry = prepateDataEntry(from: allStatDays)

    return BarChartDataSet(entries: dataEntry)
  }

  private func prepateDataEntry(from data: [StatDay]) -> [BarChartDataEntry] {
    let sortedData = data.sorted {
      guard let date0 = $0.splitDate, let date1 = $1.splitDate else { return false }
      return date0.rawDate.timeIntervalSince1970 < date1.rawDate.timeIntervalSince1970
    }
    currentlyDrawedStatDays = sortedData
    var dataEntry = [BarChartDataEntry]()

    for (index, statDay) in sortedData.enumerated() {
      let index = Double(index)
      let drawableStatDay = DrawableStatDay(statDay: statDay)
      dataEntry.append(BarChartDataEntry(x: index, y: drawableStatDay.averageState))
    }

    return dataEntry
  }
  
}
