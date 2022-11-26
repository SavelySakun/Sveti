import Charts
import UIKit

class StatsBarChartView: BarChartView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setChartStyle()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setChartStyle() {
        // General
        backgroundColor = .white
        legend.enabled = false
        extraTopOffset = 20.0
        viewPortHandler.setMaximumScaleY(1.0)

        let leftAxis = leftAxis
        let xAxis = xAxis

        // Left axis
        leftAxis.axisMaximum = 10.0
        leftAxis.axisMinimum = 0.0
        leftAxis.labelFont = .systemFont(ofSize: 12.0)
        leftAxis.axisLineColor = .systemGray2
        leftAxis.gridColor = .systemGray2

        // Right axis
        rightAxis.enabled = false

        // xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.axisLineColor = .systemGray2
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 12.0)
        xAxis.granularity = 1.0
    }
}
