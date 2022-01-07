import UIKit

class OnboardingContentView: UIView {

  private let globalBackgroundView = UIView()
  private let imageWithGradientBackground = ImageWithGradientBackground()
  private let progressView = UIProgressView(progressViewStyle: .bar)
  private let titleLabel = UILabel()
  private let subtitleLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func updateContent(slide: OnboardingSlide, progression: Float) {
    DispatchQueue.main.async { [self] in
      UIView.transition(with: self, duration: 0.4, options: .transitionCrossDissolve) {
        globalBackgroundView.backgroundColor = slide.globalBackgroundColor
        titleLabel.text = slide.title
        subtitleLabel.text = slide.subtitle
        imageWithGradientBackground.update(slide: slide)
        progressView.tintColor = (progression == 1.0) ? #colorLiteral(red: 0.2049866915, green: 0.6625028849, blue: 0.5520762801, alpha: 1) : .systemBlue
      }
      progressView.setProgress(progression, animated: true)
    }
  }

  private func setLayout() {
    setGlobalBackgroundView()
    setImageWithGradient()
    setProgressView()
    setTitleLabel()
    setSubtitleLabel()
  }

  private func setGlobalBackgroundView() {
    addSubview(globalBackgroundView)
    globalBackgroundView.backgroundColor = .orange.withAlphaComponent(0.7)

    globalBackgroundView.snp.makeConstraints { (make) in
      make.top.left.right.equalToSuperview()
      make.height.equalTo(snp.height).multipliedBy(0.3)
    }
  }

  private func setImageWithGradient() {
    addSubview(imageWithGradientBackground)
    imageWithGradientBackground.layer.cornerRadius = 12

    imageWithGradientBackground.snp.makeConstraints { (make) in
      make.centerY.equalTo(globalBackgroundView.snp.bottom)
      make.left.right.equalToSuperview().inset(28)
      make.height.equalToSuperview().multipliedBy(0.26)
    }
  }

  private func setProgressView() {
    addSubview(progressView)
    progressView.progress = 0.0
    progressView.layer.cornerRadius = 2
    progressView.trackTintColor = .systemGray5
    progressView.layer.cornerRadius = 4
    progressView.layer.masksToBounds = true

    progressView.snp.makeConstraints { (make) in
      make.top.equalTo(imageWithGradientBackground.snp.bottom).offset(29)
      make.width.equalTo(imageWithGradientBackground.snp.width).multipliedBy(0.5)
      make.height.equalTo(7)
      make.centerX.equalTo(imageWithGradientBackground.snp.centerX)
    }
  }

  private func setTitleLabel() {
    addSubview(titleLabel)
    titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .regular)
    titleLabel.numberOfLines = 0

    titleLabel.snp.makeConstraints { (make) in
      make.top.equalTo(progressView.snp.bottom).offset(42)
      make.left.right.equalToSuperview().inset(32)
    }
  }

  private func setSubtitleLabel() {
    addSubview(subtitleLabel)
    subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    subtitleLabel.textColor = .systemGray
    subtitleLabel.numberOfLines = 0

    subtitleLabel.snp.makeConstraints { (make) in
      make.top.equalTo(titleLabel.snp.bottom).offset(22)
      make.left.equalToSuperview().inset(32)
      make.right.equalToSuperview().inset(40)
    }
  }

}
