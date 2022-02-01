import UIKit
import Charts

class BarChartCell: Cell {
  private let barChartView = StatsBarChartView()
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
    barChartView.delegate = self
    addSubviews()
    setNoDataTextImage()
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
    let statTypeDescription = statType.getDescription().localizedLowercase
    currentStatLabel.text = "\("Average".localized) \(statTypeDescription)"

    guard let dataSet = StatDayContentManager.shared.getStatContent() else { return }
    dataSet.colors = StatDayChartFormatter().generateColorsForBars()
    dataSet.valueFont = .systemFont(ofSize: 12)
    dataSet.valueFormatter = StatDayValueFormatter()

    let barChartData = BarChartData(dataSet: dataSet)
    barChartView.data = barChartData
    setVisibleXRange()
    barChartView.zoomOut()
    barChartView.moveViewToX(Double(dataSet.count))
    barChartView.highlightValue(nil) // <- removes selection of bar
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
      noDataTextImage.textLabel.text = "There is nothing to analyze yet. Add the first note about how you feel".localized
      noDataTextImage.imageView.image = UIImage(named: "noDataAtAll")
    case .success:
      return
    case .noDataInTimeRange:
      noDataTextImage.textLabel.text = "There are no notes in the specified time range. But we found a cat".localized
      noDataTextImage.imageView.image = UIImage(named: "noDataFilter")
    }
  }
}

extension BarChartCell: ChartViewDelegate {

  func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
    let selectedIndex = Int(entry.x)
    notify(with: selectedIndex)
  }

  func chartValueNothingSelected(_ chartView: ChartViewBase) {
    notify()
  }

  private func notify(with index: Int? = nil) {
    let notificationName = NotificationNames.onStatBarSelect
    NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["barIndex": index as Any])
    SvetiAnalytics.log(.selectStatChartBar)
  }
}
