import Foundation
import Charts

class StatDayValueFormatter: IValueFormatter {

  func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
    let isNeedLabel = calculateNeedToShowValueLabel(entry, viewPortHandler)
    let format = isNeedLabel ? "%.1f" : ""
    return String(format: format, value)
  }

  func calculateNeedToShowValueLabel(_ entry: ChartDataEntry, _ viewPortHandler: ViewPortHandler?) -> Bool {
    guard let totalItemsCount = StatDayContentManager.shared.currentlyDrawedStat?.count else { return false }
    let isManyBars = (totalItemsCount >= 20)
    let scaleXForZoom = getScaleXZoomWhenDontShowLabels(totalItems: totalItemsCount)
    let isBigZoom = viewPortHandler?.scaleX ?? 1.0 >= scaleXForZoom
    let dontShowLabelsWhenManyBarsAndNotBigZoom = !(isManyBars && !isBigZoom)
    return dontShowLabelsWhenManyBarsAndNotBigZoom
  }

  // 'Elegant' solution for finding scaleX when don't show bar value label. Uses when many bars and labels overlap each other.
  private func getScaleXZoomWhenDontShowLabels(totalItems: Int) -> CGFloat {
    switch totalItems {
    case 21...30:
      return 1.3
    case 31...40:
      return 2.5
    case 41...50:
      return 2.5
    default:
      return 3.3
    }
  }
}
