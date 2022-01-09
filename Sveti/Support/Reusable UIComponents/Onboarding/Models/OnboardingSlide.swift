import UIKit

struct OnboardingSlide {
  let title: String
  let subtitle: String
  let globalBackgroundColor: UIColor
  let image: UIImage?
  let gradientImage: UIImage?

  init(title: String, subtitle: String, globalBackgroundColor: UIColor, image: UIImage? = nil, gradientImage: UIImage? = nil) {

    self.title = title
    self.subtitle = subtitle
    self.globalBackgroundColor = globalBackgroundColor
    self.image = image
    self.gradientImage = gradientImage
  }
}
