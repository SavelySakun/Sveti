import Foundation
import Charts

class StatDayValueFormatter: ValueFormatter {

  func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
    return String(format: "%.1f", value)
  }
}
