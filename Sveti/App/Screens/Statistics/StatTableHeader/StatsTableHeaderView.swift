import UIKit

class StatsTableHeaderView: UIView {

  let startDatePicker = UIDatePicker()
  let endDatePicker = UIDatePicker()
  let segmentedControl = UISegmentedControl(items: ["Day", "Week", "Month", "Year"])
  let pickersStackView = UIStackView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
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
}
