import UIKit
import Charts

class BarChartCell: Cell {
  private let barChart = BarChartView()

  override func setLayout() {
    configureChart()
    contentView.addSubview(barChart)
    barChart.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(UIUtils.defaultOffset)
      make.left.equalToSuperview().offset(UIUtils.defaultOffset)
      make.right.equalToSuperview().offset(-UIUtils.defaultOffset)
      make.bottom.equalToSuperview().offset(-UIUtils.defaultOffset)
      make.height.equalTo(300)
    }
  }

  private func configureChart() {
    barChart.delegate = self
    setChartStyle()

    // data
    let dataEntry = [
      BarChartDataEntry(x: 0.0, y: 2.0),
      BarChartDataEntry(x: 1.0, y: 5.0),
      BarChartDataEntry(x: 2.0, y: 6.0),
      BarChartDataEntry(x: 3.0, y: 3.0),
      BarChartDataEntry(x: 4.0, y: 8.0),
      BarChartDataEntry(x: 5.0, y: 3.0),
      BarChartDataEntry(x: 6.0, y: 5.0),
      BarChartDataEntry(x: 7.0, y: 6.0),
      BarChartDataEntry(x: 8.0, y: 3.0),
      BarChartDataEntry(x: 9.0, y: 9.0),
      BarChartDataEntry(x: 10.0, y: 10.0),
      BarChartDataEntry(x: 11.0, y: 10.0),
      BarChartDataEntry(x: 12.0, y: 8.0),
    ]

    let chartDataSet = BarChartDataSet(entries: dataEntry)
    let barChartData = BarChartData(dataSet: chartDataSet)
    barChart.data = barChartData
  }

  private func setChartStyle() {
    barChart.backgroundColor = .white
    barChart.rightAxis.enabled = false
    barChart.leftAxis.axisLineColor = .white
    barChart.fitBars = true

    let leftAxis = barChart.xAxis
    leftAxis.drawGridLinesEnabled = false
  }
}

extension BarChartCell: ChartViewDelegate {

}
