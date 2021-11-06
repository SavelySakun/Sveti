import UIKit
import Combine

class StatsTableHeaderView: UIView {

  var publisher = PassthroughSubject<Event, Never>()
  let identifier = "StatsTableHeaderView"
  let startDatePicker = UIDatePicker()
  let endDatePicker = UIDatePicker()
  let segmentedControl = UISegmentedControl(items: ["Day", "Week", "Month", "Year"])
  let pickersStackView = UIStackView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
    addTargets()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setLayout() {
    setDatePickers()
    setSegmentedControl()
  }

  private func setDatePickers() {
    [endDatePicker, startDatePicker].forEach { picker in
      picker.datePickerMode = .date
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
    [startDatePicker, calendarImageView, endDatePicker].forEach { view in
      pickersStackView.addArrangedSubview(view)
    }

    addSubview(pickersStackView)
    pickersStackView.snp.makeConstraints { (make) in
      make.height.equalTo(28)
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
    startDatePicker.addTarget(self, action: #selector(onStartDateSelect), for: .editingDidEnd)
    endDatePicker.addTarget(self, action: #selector(onEndDateSelect), for: .editingDidEnd)
    segmentedControl.addTarget(self, action: #selector(onSegmentedControlValueChanged), for: .valueChanged)
  }

  @objc private func onStartDateSelect() {
    let event = StatsFilterEvent(type: .selectStartDate, value: "")
    publisher.send(event)
  }

  @objc private func onEndDateSelect() {
    let event = StatsFilterEvent(type: .selectEndDate, value: "")
    publisher.send(event)
  }

  @objc private func onSegmentedControlValueChanged(_ sender: UISegmentedControl) {
    guard let selectedGrouping = GroupingType(rawValue: sender.selectedSegmentIndex) else { return }
    let event = StatsFilterEvent(type: .changeGrouping, value: selectedGrouping)
    publisher.send(event)
  }
}
