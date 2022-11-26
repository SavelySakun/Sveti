import UIKit

class ImageWithGradientBackground: UIView {
    private let gradientImageView = UIImageView()
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        setGradientImageView()
        setImageView()
    }

    private func setImageView() {
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalToSuperview().multipliedBy(0.8)
        }
    }

    private func setGradientImageView() {
        addSubview(gradientImageView)
        gradientImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        gradientImageView.contentMode = .scaleAspectFill
        gradientImageView.layer.cornerRadius = 12
        gradientImageView.clipsToBounds = true
    }

    func update(slide: OnboardingSlide) {
        gradientImageView.image = slide.gradientImage
        imageView.image = slide.image
    }
}
