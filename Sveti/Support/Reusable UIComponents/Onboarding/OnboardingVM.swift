import Foundation

class OnboardingVM: IOnboardingVM {
  var onboardingState: OnboardingState = .firstSlide
  var currentSlideIndex: Int = 0
  var onboardingKey: String
  var slides: [OnboardingSlide]

  private let userDefaults = UserDefaults()
  
  init(userDefaultsKey: String, slides: [OnboardingSlide]) {
    self.onboardingKey = userDefaultsKey
    self.slides = slides
    setupDefaults()
  }

  func markAsWatched() {
    userDefaults.set(true, forKey: onboardingKey)
  }

  func getOnboardingWatchStatus() -> Bool {
    userDefaults.bool(forKey: onboardingKey)
  }

  func setupDefaults() {
    userDefaults.register(
      defaults: [self.onboardingKey: false]
    )
  }

  func updateOnboardingProgression(direction: OnboardingMoveDirection) {
    currentSlideIndex += (direction == .next) ? 1 : -1

    if slides.indices.last == currentSlideIndex {
      onboardingState = .lastSlide
    } else if slides.indices.first == currentSlideIndex {
      onboardingState = .firstSlide
    } else if slides.indices.contains(currentSlideIndex) {
      onboardingState = .hasSlides
    }
  }

  func getSlide() -> OnboardingSlide? {
    slides[safe: currentSlideIndex]
  }

  func getOnboardingProgressionValue() -> Float {
    let currentSlideIndex = Float(currentSlideIndex)
    let slidesCount = Float(slides.count - 1) // need to show 100% full progress bar on last slide
    return currentSlideIndex / slidesCount
  }
}
