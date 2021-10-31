import UIKit
import Charts

class BarChartCell: Cell {

  private let barChartView = BarChartView()

  override func setLayout() {
    configureChart()
    contentView.addSubview(barChartView)
    barChartView.snp.makeConstraints { (make) in
      make.top.left.equalToSuperview().offset(UIUtils.defaultOffset)
      make.right.bottom.equalToSuperview().offset(-UIUtils.defaultOffset)
      make.height.equalTo(250)
    }
  }

  private func configureChart() {
    barChartView.delegate = self
    setChartStyle()

    // data
    let dataEntry = [
      BarChartDataEntry(x: 0.0, y: 2),
      BarChartDataEntry(x: 1.0, y: 5),
    ]

    let chartDataSet = BarChartDataSet(entries: dataEntry)
    chartDataSet.colors = [.systemTeal]
    chartDataSet.highlightColor = .systemBlue
    chartDataSet.valueFont = .systemFont(ofSize: 12)

    let barChartData = BarChartData(dataSet: chartDataSet)
    barChartView.data = barChartData
  }

  private func setChartStyle() {
    // General
    barChartView.backgroundColor = .white
    barChartView.fitBars = true
    barChartView.legend.enabled = false

    let leftAxis = barChartView.leftAxis
    let xAxis = barChartView.xAxis

    // Left axis
    leftAxis.axisMaximum = 10.0
    leftAxis.labelFont = .systemFont(ofSize: 12.0)
    leftAxis.axisLineColor = .systemGray2
    leftAxis.gridColor = .systemGray2

    // Right axis
    barChartView.rightAxis.enabled = false

    // xAxis
    xAxis.drawGridLinesEnabled = false
    xAxis.axisLineColor = .systemGray2
    xAxis.labelPosition = .bottom
    xAxis.labelFont = .systemFont(ofSize: 12.0)
  }
}

extension BarChartCell: ChartViewDelegate {

}
