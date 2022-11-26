import UIKit

class ScoreTimeView: UIView {
    let scoreLabel = UILabel()
    let timeLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with note: Note) {
        timeLabel.text = getTime(from: note)
        scoreLabel.text = SvetiMath().getAverageMood(from: note)
    }

    private func getTime(from note: Note) -> String {
        guard let hourString = note.splitDate?.HHmm else { return "" }
        return String(format: NSLocalizedString("at %@", comment: ""), hourString)
    }

    private func setLayout() {
        setLabelsStyle()
        setLabelsLayout()
    }

    private func setLabelsStyle() {
        scoreLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        scoreLabel.textColor = .blue
        timeLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }

    private func setLabelsLayout() {
        let stackView = UIStackView(arrangedSubviews: [scoreLabel, timeLabel])
        stackView.axis = .horizontal
        stackView.alignment = .firstBaseline
        stackView.spacing = 6

        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
