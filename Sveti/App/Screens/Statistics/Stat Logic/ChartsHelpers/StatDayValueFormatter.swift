import Foundation
import Charts

class StatDayValueFormatter: IValueFormatter {

  func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
    return String(format: "%.1f", value)
  }
}
