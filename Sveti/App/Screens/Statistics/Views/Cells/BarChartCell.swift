import UIKit
import Charts

class BarChartCell: Cell {
  private let barChartView = BarChartView()
  private let noDataTextImage = ImageTextView()
  private let currentStatLabel = UILabel()
  private var contentGenerationResult: StatGenerationResult {
    StatDayContentManager.shared.contentGenerationResult
  }

  override func configureSelf(with viewModel: CellVM) {
    configureChart()
  }

  override func setLayout() {
    selectionStyle = .none
    addSubviews()
    setNoDataTextImage()
    setChartStyle()
  }

  private func addSubviews() {
    contentView.addSubview(barChartView)
    barChartView.snp.makeConstraints { (make) in
      make.left.top.equalToSuperview().offset(UIUtils.defaultOffset)
      make.right.equalToSuperview().offset(-UIUtils.defaultOffset)
      make.height.equalTo(250)
    }
    currentStatLabel.textColor = .systemGray
    currentStatLabel.font = UIFont.systemFont(ofSize: 13)
    contentView.addSubview(currentStatLabel)
    currentStatLabel.snp.makeConstraints { (make) in
      make.centerX.equalTo(barChartView)
      make.top.equalTo(barChartView.snp.bottom).offset(UIUtils.defaultOffset)
      make.bottom.equalToSuperview().offset(-UIUtils.bigOffset)
      make.height.equalTo(15)
    }
  }

  private func configureChart() {
    barChartView.delegate = self
    setDataForChart()
    let isHasContent = (contentGenerationResult == .success)
    updateContentVisibility(isHasContent: isHasContent)
    guard isHasContent else { return }
    animateBar()
    barChartView.xAxis.valueFormatter = StatDayChartFormatter()
  }

  private func animateBar() {
    let animationDuration = 0.6
    DispatchQueue.main.async {
      self.barChartView.animate(yAxisDuration: animationDuration)
    }
  }

  private func setDataForChart() {
    let statType = StatSettingsRepository().settings.statType
    let statTypeDescription = statType.getStatTypeDescription().lowercased()
    currentStatLabel.text = "\("Average".localized) \(statTypeDescription.localized)"

    guard let dataSet = StatDayContentManager.shared.getStatContent() else { return }
    dataSet.highlightEnabled = false
    dataSet.colors = StatDayChartFormatter().generateColorsForBars()
    dataSet.valueFont = .systemFont(ofSize: 12)
    dataSet.valueFormatter = StatDayValueFormatter()

    let barChartData = BarChartData(dataSet: dataSet)
    barChartView.data = barChartData
    setVisibleXRange()
    barChartView.zoomOut()
    barChartView.moveViewToX(Double(dataSet.count))
  }

  private func setChartStyle() {
    // General
    barChartView.backgroundColor = .white
    barChartView.legend.enabled = false
    barChartView.extraTopOffset = 20.0
    barChartView.viewPortHandler.setMaximumScaleY(1.0)

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
    xAxis.drawGridLinesEnabled = false
    xAxis.axisLineColor = .systemGray2
    xAxis.labelPosition = .bottom
    xAxis.labelFont = .systemFont(ofSize: 12.0)
    xAxis.granularity = 1.0
  }

  private func setVisibleXRange() {
    guard StatDayContentManager.shared.isHasContentToDraw() else { return }
    barChartView.setVisibleYRange(minYRange: 10, maxYRange: 10, axis: .left)

    guard let currentVC = CurrentVC.current else { return }
    let currentVCWidth = currentVC.view.frame.width
    let barItemMinimalWidth: CGFloat = 30.0
    let totalAvailableItems = Double(currentVCWidth / barItemMinimalWidth)
    barChartView.setVisibleXRange(minXRange: 5, maxXRange: totalAvailableItems)
  }

  private func setNoDataTextImage() {
    contentView.addSubview(noDataTextImage)
    noDataTextImage.snp.makeConstraints { (make) in
      make.top.equalToSuperview().inset(50)
      make.bottom.equalToSuperview().inset(UIUtils.bigOffset)
      make.centerX.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.8)
      make.height.equalToSuperview().multipliedBy(0.7)
    }
  }

  private func updateContentVisibility(isHasContent: Bool) {
    barChartView.isHidden = !isHasContent
    noDataTextImage.isHidden = isHasContent
    currentStatLabel.isHidden = !isHasContent
    guard !isHasContent else { return }
    switch contentGenerationResult {
    case .noDataAtAll:
      noDataTextImage.textLabel.text = "There is nothing to analyze yet. Add the first note about how you feel.".localized
      noDataTextImage.imageView.image = UIImage(named: "noDataAtAll")
    case .success:
      return
    case .noDataInTimeRange:
      noDataTextImage.textLabel.text = "There are no notes in the specified time range. Only the cat was found.".localized
      noDataTextImage.imageView.image = UIImage(named: "noDataFilter")
    }
  }
}

extension BarChartCell: ChartViewDelegate {

}
