import UIKit

class DatePickerCell: Cell {
  private let datePicker = UIDatePicker()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureLayout()
  }

  override func configureSelf(with viewModel: CellVM) {
    super.configureSelf(with: viewModel)
    if let note = viewModel.cellValue as? Note {
      datePicker.date = note.splitDate?.rawDate ?? Date()
    } else {
      datePicker.date = Date()
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureLayout() {
    datePicker.addTarget(self, action: #selector(onDateChange), for: .valueChanged)
    contentView.backgroundColor = .clear
    datePicker.preferredDatePickerStyle = .compact

    contentView.addSubview(datePicker)
    datePicker.snp.makeConstraints { (make) in
      make.top.left.right.bottom.equalToSuperview()
    }
  }

  @objc private func onDateChange(sender: UIDatePicker) {
    let event = EditEvent(type: .dateChange, value: sender.date)
    publisher.send(event)
  }

}
