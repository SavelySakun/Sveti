import UIKit
import Charts

class BarChartCell: Cell {
  private let barChartView = BarChartView()
  private let noDataTextImage = ImageTextView()
  private var contentGenerationResult: StatGenerationResult {
    StatDayContentManager.shared.contentGenerationResult
  }

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
    setNoDataTextImage()
  }

  private func configureChart() {
    barChartView.delegate = self
    setDataForChart()
    guard contentGenerationResult == .success else {
      handleIfNoData()
      return
    }
    barChartView.isHidden = false
    noDataTextImage.isHidden = true
    setChartStyle()
    setVisibleXRange()
  }

  private func setDataForChart() {
    guard let dataSet = StatDayContentManager.shared.getStatContent() else { return }
    dataSet.colors = [.systemTeal]
    dataSet.highlightColor = .systemBlue
    dataSet.valueFont = .systemFont(ofSize: 12)
    dataSet.valueFormatter = StatDayValueFormatter()
    let barChartData = BarChartData(dataSet: dataSet)
    barChartView.data = barChartData
  }

  private func setChartStyle() {
    // General
    barChartView.backgroundColor = .white
    barChartView.legend.enabled = false
    barChartView.extraTopOffset = 20.0

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
    //guard let statDays = StatDaysDataSetGenerator.shared.currentlyDrawedStat, !statDays.isEmpty else { return }
    barChartView.setVisibleYRange(minYRange: 10, maxYRange: 10, axis: .left)
    barChartView.setVisibleXRange(minXRange: 0, maxXRange: 25)
  }

  private func setNoDataTextImage() {
    contentView.addSubview(noDataTextImage)
    noDataTextImage.snp.makeConstraints { (make) in
      make.centerX.centerY.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.8)
      make.height.equalToSuperview().multipliedBy(0.7)
    }
  }

  private func handleIfNoData() {
    barChartView.isHidden = true
    noDataTextImage.isHidden = false
    switch contentGenerationResult {
    case .noDataAtAll:
      noDataTextImage.textLabel.text = "There is nothing to analyze yet. Add the first note about how you feel."
      noDataTextImage.imageView.image = UIImage(named: "noDataAtAll")
    case .success:
      return
    case .noDataInTimeRange:
      noDataTextImage.textLabel.text = "There are no notes in the specified time range. Only the cat was found."
      noDataTextImage.imageView.image = UIImage(named: "noDataFilter")
    }
  }
}

extension BarChartCell: ChartViewDelegate {

}
