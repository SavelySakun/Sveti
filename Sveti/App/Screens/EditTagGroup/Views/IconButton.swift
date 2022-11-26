import UIKit

class ButtonIconView: UIView {
    let iconImageView = UIImageView()

    init() {
        super.init(frame: .zero)
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 12
        setImageView()
    }

    private func setImageView() {
        iconImageView.image = UIImage(named: "tag")?.withRenderingMode(.alwaysTemplate)
        iconImageView.contentMode = .scaleAspectFit
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(22)
            make.top.equalToSuperview().offset(UIUtils.defaultOffset)
            make.left.equalToSuperview().offset(UIUtils.defaultOffset)
            make.bottom.equalToSuperview().offset(-UIUtils.defaultOffset)
            make.right.equalToSuperview().offset(-UIUtils.defaultOffset)
        }
    }
}
