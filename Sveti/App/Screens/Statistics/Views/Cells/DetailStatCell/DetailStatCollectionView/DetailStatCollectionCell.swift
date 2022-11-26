import UIKit

class DetailStatCollectionCell: UICollectionViewCell {
    static let reuseId = "DetailStatCollectionCell"
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitlesStyle()
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setDetailStat(with item: DetailStatItem) {
        titleLabel.text = item.title
        valueLabel.text = item.value
        iconImageView.image = UIImage(named: item.iconName)
    }

    private func setTitlesStyle() {
        titleLabel.font = .systemFont(ofSize: 14, weight: .light)
        valueLabel.font = .systemFont(ofSize: 14, weight: .medium)
    }

    private func setLayout() {
        backgroundColor = .white
        layer.cornerRadius = 8

        let contentStackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel, valueLabel])
        contentStackView.spacing = 7
        contentStackView.axis = .horizontal

        let iconWidthHeight = 18
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(iconWidthHeight)
        }

        addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIUtils.defaultOffset)
        }
    }
}
