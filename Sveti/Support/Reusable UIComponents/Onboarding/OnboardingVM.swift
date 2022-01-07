import Foundation

class OnboardingVM: IOnboardingVM {
  var onboardingState: OnboardingState = .firstSlide
  var currentSlideIndex: Int = 0
  var onboardingKey: String
  var slides: [OnboardingSlide]
  
  init(key: String, slides: [OnboardingSlide]) {
    self.onboardingKey = key
    self.slides = slides
  }

  func updateOnboardingWatchStatus() {
    //
  }

  func getOnboardingWatchStatus() -> Bool {
    true
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


