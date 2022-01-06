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

  func setContent(slide: OnboardingSlide) {
    //
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
    progressView.setProgress(0.3, animated: true)
    progressView.layer.cornerRadius = 2
    progressView.trackTintColor = .systemGray5
    progressView.tintColor = .systemBlue
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
    titleLabel.text = "It's very late to answer but actually I had the same problem."

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
    subtitleLabel.text = "Days above sea female seas. You rule man day. Heaven him that whales void signs. There unto. Under created created. The it upon called give the own moved bring air."

    subtitleLabel.snp.makeConstraints { (make) in
      make.top.equalTo(titleLabel.snp.bottom).offset(22)
      make.left.equalToSuperview().inset(32)
      make.right.equalToSuperview().inset(40)
    }
  }

}
