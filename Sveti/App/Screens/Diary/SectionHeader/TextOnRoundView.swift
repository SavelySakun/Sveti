import UIKit

class TextOnRoundView: UIView {
    let textLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        setBackground()
        addScore()
    }

    private func setBackground() {
        backgroundColor = .systemGray5
        layer.cornerRadius = 6.5
    }

    private func addScore() {
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.left.right.equalToSuperview().inset(10)
        }
    }
}
