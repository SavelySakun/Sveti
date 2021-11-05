import Foundation
import Charts

class StatDayChartFormatter: IAxisValueFormatter {

  private var xAxisLabels = [String]()

  init() {
    configureLabels()
  }

  private func configureLabels() {
    guard let statDays = StatDaysDataSetManager.shared.currentlyDrawedStatDays else { return }
    statDays.forEach { statDay in
      guard let splitDate = statDay.splitDate else { return }
      xAxisLabels.append(splitDate.dMM)
    }
  }

  func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    let index = Int(value)
    guard let label = xAxisLabels[safe: index] else { return "error" }
    return label
  }
}

