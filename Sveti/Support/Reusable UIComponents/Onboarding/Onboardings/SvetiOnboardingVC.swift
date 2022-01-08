import UIKit

class SvetiOnboardingVC: OnboardingVC {
  init() {
    super.init(viewModel: OnboardingVM(userDefaultsKey: "SvetiOnboarding", slides: [

      OnboardingSlide(title: "What is Sveti?", subtitle: "Sveti is your well-being diary. Add entries, specify tags, and, of course, see statistics.", globalBackgroundColor: #colorLiteral(red: 1, green: 0.8, blue: 0.4470588235, alpha: 1), image: UIImage(named: "noDataFilter")),

      OnboardingSlide(title: "Why Sveti?", subtitle: "The main difference from other diaries is that you can track both your physical and emotional state.", globalBackgroundColor: #colorLiteral(red: 0.8705882353, green: 0.8862745098, blue: 1, alpha: 1), image: UIImage(named: "purrtea"), gradientImage: UIImage(named: "")),

      OnboardingSlide(title: "Notice the trends of your well-being", subtitle: "A trend noticed at an early stage allows you to change the factors influencing it.", globalBackgroundColor: #colorLiteral(red: 0.7764705882, green: 0.8549019608, blue: 0.7490196078, alpha: 1), image: UIImage(named: "purrstat")),

      OnboardingSlide(title: "All information stored in Sveti is absolutely private", subtitle: "Records & statistics are saved only on your device and no one has access to them.", globalBackgroundColor: #colorLiteral(red: 0.7450980392, green: 0.9137254902, blue: 0.9098039216, alpha: 1), image: UIImage(named: "purrsafe"))
    ]))

    title = "Welcome to Sveti"
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
