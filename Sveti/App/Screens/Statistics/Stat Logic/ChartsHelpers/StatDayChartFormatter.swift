import Foundation
import Charts

class StatDayChartFormatter: IAxisValueFormatter {

  private var xAxisLabels = [String]()

  init() {
    configureLabels()
  }

  private func configureLabels() {
    guard let currentlyDrawedStat = StatDayContentManager.shared.currentlyDrawedStat else { return }
    let groupingType = StatSettingsRepository().settings.groupingType

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

  func generateColorsForBars() -> [UIColor] {
    let statType = StatSettingsRepository().settings.statType
    guard let currentlyDrawedStat = StatDayContentManager.shared.currentlyDrawedStat else { return [UIColor]() }
    var colorsForBars = [UIColor]()

    currentlyDrawedStat.forEach { drawableStat in
      let colorHelper = ColorHelper()
      var moodValue: Int

      switch statType {
      case .averageEmotional:
        moodValue = drawableStat.averageEmotional.toInt()
      case .averagePhysical:
        moodValue = drawableStat.averagePhysical.toInt()
      case .averageEmotionalAndPhysical:
        moodValue = drawableStat.averageState.toInt()
      }

      let color = colorHelper.getColor(value: moodValue, alpha: 0.95)
      colorsForBars.append(color)
    }

    return colorsForBars
  }
}

