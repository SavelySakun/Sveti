import UIKit

enum OnboardingSlides {
  static let testSlides: [OnboardingSlide] = [
    OnboardingSlide(title: "title1", subtitle: "subtitle1", globalBackgroundColor: .gray, image: UIImage(named: "purrstat"), gradientImage: UIImage(named: "gradientMulti")),
    OnboardingSlide(title: "title2", subtitle: "subtitle2", globalBackgroundColor: .gray, image: UIImage(named: "purrtea"), gradientImage: UIImage(named: "gradientMulti")),
  ]

  static let svetiOnboarding: [OnboardingSlide] = [
    OnboardingSlide(title: "What is Sveti?".localized, subtitle: "Sveti is your well-being diary. Add entries, specify tags, and, of course, see statistics.".localized, globalBackgroundColor: #colorLiteral(red: 1, green: 0.8, blue: 0.4470588235, alpha: 1), image: UIImage(named: "noDataFilter")),
    OnboardingSlide(title: "Why Sveti?".localized, subtitle: "The main difference from other diaries is that you can track both your physical and emotional state.".localized, globalBackgroundColor: #colorLiteral(red: 0.8705882353, green: 0.8862745098, blue: 1, alpha: 1), image: UIImage(named: "purrtea")),
    OnboardingSlide(title: "Why track your mood?".localized, subtitle: "Tracking your condition helps understand what exactly makes it worse or better.".localized, globalBackgroundColor: #colorLiteral(red: 0.7764705882, green: 0.8549019608, blue: 0.7490196078, alpha: 1), image: UIImage(named: "purrstat")),
    OnboardingSlide(title: "All information stored in Sveti is absolutely private".localized, subtitle: "No one has access to your notes and statistics. Cloud saves are stored in Apple's private database linked to your iCloud account.".localized, globalBackgroundColor: #colorLiteral(red: 0.7450980392, green: 0.9137254902, blue: 0.9098039216, alpha: 1), image: UIImage(named: "purrsafe"))
  ]
}
