import UIKit
import Combine

class StatsTableHeaderView: UIView {

  var publisher = PassthroughSubject<Event, Never>()
  let identifier = "StatsTableHeaderView"
  let minimumDatePicker = UIDatePicker()
  let maximumDatePicker = UIDatePicker()
  let segmentedControl = UISegmentedControl(items: ["Day".localized, "Week".localized, "Month".localized, "Year".localized])
  let pickersStackView = UIStackView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
    addTargets()
    setDefaultValues()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setLayout() {
    setDatePickers()
    setSegmentedControl()
  }

  private func setDatePickers() {
    minimumDatePicker.date = SplitDate(ddMMyyyy: "01.01.2015").rawDate
    [maximumDatePicker, minimumDatePicker].forEach { picker in
      picker.datePickerMode = .date
      picker.maximumDate = Date()
    }
    setDatePickersLayout()
  }

  private func setDatePickersLayout() {
    let calendarImage = UIImage(named: "Calendar")?.withRenderingMode(.alwaysTemplate)
    let calendarImageView = UIImageView(image: calendarImage)
    calendarImageView.contentMode = .scaleAspectFit
    calendarImageView.tintColor = .systemGray2
    calendarImageView.snp.makeConstraints { (make) in
      make.width.height.equalTo(20)
    }

    pickersStackView.spacing = 12
    [minimumDatePicker, calendarImageView, maximumDatePicker].forEach { view in
      pickersStackView.addArrangedSubview(view)
    }

    addSubview(pickersStackView)
    pickersStackView.snp.makeConstraints { (make) in
      make.height.equalTo(36)
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().inset(18)
    }
  }

  private func setSegmentedControl() {
    segmentedControl.selectedSegmentIndex = 0
    addSubview(segmentedControl)
    segmentedControl.snp.makeConstraints { (make) in
      make.top.equalTo(pickersStackView.snp.bottom).offset(15)
      make.centerX.equalTo(pickersStackView.snp.centerX)
    }
  }

  private func addTargets() {
    minimumDatePicker.addTarget(self, action: #selector(onMinimumDateSelect), for: .editingDidEnd)
    maximumDatePicker.addTarget(self, action: #selector(onMaximumDateSelect), for: .editingDidEnd)
    segmentedControl.addTarget(self, action: #selector(onSegmentedControlValueChanged), for: .valueChanged)
  }

  private func setDefaultValues() {
    let settings = StatSettingsRepository().settings
    minimumDatePicker.date = settings.minimumDate
    maximumDatePicker.date = settings.maximumDate
    segmentedControl.selectedSegmentIndex = settings.groupingType.rawValue
  }

  @objc private func onMinimumDateSelect() {
    let event = StatsFilterEvent(type: .selectMinumumDate, value: minimumDatePicker.date)
    publisher.send(event)
  }

  @objc private func onMaximumDateSelect() {
    let event = StatsFilterEvent(type: .selectMaximumDate, value: maximumDatePicker.date)
    publisher.send(event)
  }

  @objc private func onSegmentedControlValueChanged(_ sender: UISegmentedControl) {
    guard let selectedGrouping = GroupingType(rawValue: sender.selectedSegmentIndex) else { return }
    let event = StatsFilterEvent(type: .changeGrouping, value: selectedGrouping)
    publisher.send(event)
  }
}
