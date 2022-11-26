import UIKit

class TagSectionFooterView: UICollectionReusableView {
    static let identifier = "tagSectionFooter"
    private let offset = 16
    var isLastSection = false {
        didSet {
            self.isHidden = isLastSection
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        let separatorView = UIView()
        separatorView.backgroundColor = .systemGray5
        separatorView.isHidden = true // hided
        addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
