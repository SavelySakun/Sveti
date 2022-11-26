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

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        datePicker.addTarget(self, action: #selector(onDateChange), for: .editingDidEnd)
        contentView.backgroundColor = .clear
        datePicker.preferredDatePickerStyle = .compact
        datePicker.maximumDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date())

        contentView.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
        }
    }

    @objc private func onDateChange(sender: UIDatePicker) {
        let event = EditEvent(type: .dateChange, value: sender.date)
        publisher.send(event)
    }
}
