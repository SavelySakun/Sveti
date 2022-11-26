import DeviceKit
import SnapKit
import UIKit

class OnboardingContentView: UIView {
    private let globalBackgroundView = UIView()
    private let imageWithBackground = ImageWithGradientBackground()
    private let progressView = UIProgressView(progressViewStyle: .bar)
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private var orientationConstraints = OrientationConstraints()

    override func layoutSubviews() {
        super.layoutSubviews()
        orientationConstraints.update()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setAccessibilityIndicators()
        setLayout()
    }

    private func setAccessibilityIndicators() {
        titleLabel.accessibilityIdentifier = "titleLabel"
        accessibilityIdentifier = "onboardingContentView"
        progressView.accessibilityIdentifier = "progressView"
        globalBackgroundView.accessibilityIdentifier = "globalBackgroundView"
        imageWithBackground.accessibilityIdentifier = "imageWithBackground"
        subtitleLabel.accessibilityIdentifier = "subtitleLabel"
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateContent(slide: OnboardingSlide, progression: Float) {
        DispatchQueue.main.async { [self] in
            UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve) {
                globalBackgroundView.backgroundColor = slide.globalBackgroundColor
                titleLabel.text = slide.title
                subtitleLabel.text = slide.subtitle
                imageWithBackground.update(slide: slide)
                progressView.tintColor = (progression == 1.0) ? #colorLiteral(red: 0.2049866915, green: 0.6625028849, blue: 0.5520762801, alpha: 1) : .systemBlue
            }
            progressView.setProgress(progression, animated: true)
            progressView.accessibilityIdentifier = (progression == 1.0) ? "fullProgressView" : "progressView"
        }
    }

    private func setLayout() {
        setGlobalBackgroundView()
        setImageWithGradient()
        setProgressView()
        setTitleLabel()
        setSubtitleLabel()
        orientationConstraints.update()
    }

    private func setGlobalBackgroundView() {
        addSubview(globalBackgroundView)
        globalBackgroundView.backgroundColor = .orange.withAlphaComponent(0.7)

        globalBackgroundView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(-50) // Inset for horizontal layout & correct safearealayoutguides
            make.height.equalTo(snp.height).multipliedBy(0.3)
        }
    }

    private func setImageWithGradient() {
        addSubview(imageWithBackground)
        imageWithBackground.layer.cornerRadius = 12
        imageWithBackground.snp.makeConstraints { make in
            make.centerY.equalTo(globalBackgroundView.snp.bottom)
            make.centerX.equalToSuperview()

            orientationConstraints.portraitConstraints.append(contentsOf: [
                make.width.equalToSuperview().multipliedBy(0.87).constraint,
                make.centerY.equalTo(globalBackgroundView.snp.bottom).constraint,
                make.height.equalToSuperview().multipliedBy(0.26).constraint,
            ])

            orientationConstraints.horizontalConstraints.append(contentsOf: [
                make.width.equalToSuperview().multipliedBy(0.3).constraint,
                make.height.equalToSuperview().multipliedBy(0.3).constraint,
            ])
        }
    }

    private func setProgressView() {
        addSubview(progressView)
        progressView.progress = 0.0
        progressView.layer.cornerRadius = 2
        progressView.trackTintColor = .systemGray5
        progressView.layer.cornerRadius = 4
        progressView.layer.masksToBounds = true

        progressView.snp.makeConstraints { make in
            make.top.equalTo(imageWithBackground.snp.bottom).offset(DeviceUtils.isSmallDiagonal ? 15 : 29)
            make.width.equalTo(imageWithBackground.snp.width).multipliedBy(0.3)
            make.height.equalTo(7)
            make.centerX.equalTo(imageWithBackground.snp.centerX)
        }
    }

    private func setTitleLabel() {
        addSubview(titleLabel)
        let titleFontSize: CGFloat = DeviceUtils.isSmallDiagonal ? 18.0 : 22.0
        titleLabel.font = UIFont.systemFont(ofSize: titleFontSize, weight: .regular)
        titleLabel.numberOfLines = 0

        titleLabel.snp.makeConstraints { make in
            orientationConstraints.portraitConstraints.append(
                make.top.equalTo(progressView.snp.bottom).offset((Device.current.diagonal <= 5.5) ? 18 : 42).constraint
            )
            orientationConstraints.horizontalConstraints.append(
                make.top.equalTo(progressView.snp.bottom).offset(18).constraint
            )
            make.left.right.equalToSuperview().inset(32)
        }
    }

    private func setSubtitleLabel() {
        addSubview(subtitleLabel)
        let subtitleFontSize: CGFloat = DeviceUtils.isSmallDiagonal ? 14.0 : 16.0
        subtitleLabel.font = UIFont.systemFont(ofSize: subtitleFontSize, weight: .regular)
        subtitleLabel.textColor = .systemGray
        subtitleLabel.numberOfLines = 0

        subtitleLabel.snp.makeConstraints { make in
            orientationConstraints.portraitConstraints.append(
                make.top.equalTo(titleLabel.snp.bottom).offset(DeviceUtils.isSmallDiagonal ? 12 : 22).constraint
            )
            orientationConstraints.horizontalConstraints.append(
                make.top.equalTo(titleLabel.snp.bottom).offset(12).constraint
            )

            make.left.equalToSuperview().inset(32)
            make.right.equalToSuperview().inset(35)
        }
    }
}
