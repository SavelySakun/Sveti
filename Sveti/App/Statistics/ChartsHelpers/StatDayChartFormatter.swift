import Foundation
import Charts

class StatDayChartFormatter: IAxisValueFormatter {

  private var xAxisLabels = [String]()

  init() {
    configureLabels()
  }

  private func configureLabels() {
    guard let currentlyDrawedStat = StatDaysDataSetManager.shared.currentlyDrawedStat else { return }
    let groupingType = StatDaysDataSetManager.shared.groupingType

    currentlyDrawedStat.forEach { drawableStat in
      let splitDate = drawableStat.splitDate
      switch groupingType {
      case .day:
        xAxisLabels.append(splitDate.dMM)
      case .week:
        xAxisLabels.append(splitDate.ddMMyy)
      case .month:
        xAxisLabels.append(splitDate.MMYY)
      case .year:
        xAxisLabels.append(splitDate.yyyy)
      }
    }
  }

  func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    let index = Int(value)
    guard let label = xAxisLabels[safe: index] else { return "error" }
    return label
  }
}

