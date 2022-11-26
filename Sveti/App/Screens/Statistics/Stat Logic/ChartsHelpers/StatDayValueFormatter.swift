import Charts
import Foundation

class StatDayValueFormatter: ValueFormatter {
    func stringForValue(_ value: Double, entry _: ChartDataEntry, dataSetIndex _: Int, viewPortHandler _: ViewPortHandler?) -> String {
        return String(format: "%.1f", value)
    }
}
