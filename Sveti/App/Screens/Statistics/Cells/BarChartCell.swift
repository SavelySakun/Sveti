import UIKit
import Charts

class BarChartCell: Cell {

  private let barChartView = BarChartView()

  override func configureSelf(with viewModel: CellVM) {
    configureChart()
  }

  override func setLayout() {
    selectionStyle = .none
    contentView.addSubview(barChartView)
    barChartView.snp.makeConstraints { (make) in
      make.top.left.equalToSuperview().offset(UIUtils.defaultOffset)
      make.right.bottom.equalToSuperview().offset(-UIUtils.defaultOffset)
      make.height.equalTo(250)
    }
  }

  private func configureChart() {
    barChartView.delegate = self
    setDataForChart()
    setChartStyle()
    setVisibleXRange()
  }

  private func setDataForChart() {
    let statDaysDataSetManager = StatDaysDataSetManager.shared

    guard let chartDataSet = statDaysDataSetManager.getAllOrderedByDay() else { return }
    chartDataSet.colors = [.systemTeal]
    chartDataSet.highlightColor = .systemBlue
    chartDataSet.valueFont = .systemFont(ofSize: 12)
    chartDataSet.valueFormatter = StatDayValueFormatter()

    // https://github.com/danielgindi/Charts/issues/1340 по хaxis инфа как делать кастомный текст

    let barChartData = BarChartData(dataSet: chartDataSet)
    barChartView.data = barChartData
  }

  private func setChartStyle() {
    // General
    barChartView.backgroundColor = .white
    barChartView.legend.enabled = false

    let leftAxis = barChartView.leftAxis
    let xAxis = barChartView.xAxis

    // Left axis
    leftAxis.axisMaximum = 10.0
    leftAxis.axisMinimum = 0.0
    leftAxis.labelFont = .systemFont(ofSize: 12.0)
    leftAxis.axisLineColor = .systemGray2
    leftAxis.gridColor = .systemGray2

    // Right axis
    barChartView.rightAxis.enabled = false

    // xAxis
    xAxis.valueFormatter = StatDayChartFormatter()
    xAxis.drawGridLinesEnabled = false
    xAxis.axisLineColor = .systemGray2
    xAxis.labelPosition = .bottom
    xAxis.labelFont = .systemFont(ofSize: 12.0)
    xAxis.granularity = 1.0
  }

  private func setVisibleXRange() {
    guard let statDays = StatDaysDataSetManager.shared.currentlyDrawedStatDays, !statDays.isEmpty else { return }
    barChartView.setVisibleYRange(minYRange: 10, maxYRange: 10, axis: .left)
    barChartView.setVisibleXRange(minXRange: 0, maxXRange: 25)
  }
}

extension BarChartCell: ChartViewDelegate {

}
