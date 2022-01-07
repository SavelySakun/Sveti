import UIKit

class SvetiOnboardingVC: OnboardingVC {
  init() {
    super.init(viewModel: OnboardingVM(key: "SvetiOnboarding", slides: [

      OnboardingSlide(title: "What is Sveti?", subtitle: "Sveti is your well-being diary. Add entries, specify tags, and, of course, see statistics.", globalBackgroundColor: #colorLiteral(red: 1, green: 0.8, blue: 0.4470588235, alpha: 1), imageBackgroundGradientColors: [#colorLiteral(red: 1, green: 0.7031058073, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.4022059441, blue: 0, alpha: 1)], image: UIImage(named: "noDataFilter")),

      OnboardingSlide(title: "Why Sveti?", subtitle: "The main difference from other diaries is that you can track both your physical and emotional state.", globalBackgroundColor: #colorLiteral(red: 0.8705882353, green: 0.8862745098, blue: 1, alpha: 1), imageBackgroundGradientColors: [#colorLiteral(red: 0.5058823529, green: 0.3529411765, blue: 0.7529411765, alpha: 1), #colorLiteral(red: 0.3843137255, green: 0.2784313725, blue: 0.6666666667, alpha: 1)], image: UIImage(named: "purrtea")),

      OnboardingSlide(title: "Notice the trends of your well-being", subtitle: "A trend noticed at an early stage allows you to change the factors influencing it.", globalBackgroundColor: #colorLiteral(red: 0.7764705882, green: 0.8549019608, blue: 0.7490196078, alpha: 1), imageBackgroundGradientColors: [#colorLiteral(red: 0.3333333333, green: 0.6509803922, blue: 0.1882352941, alpha: 1), #colorLiteral(red: 0.168627451, green: 0.5764705882, blue: 0.2823529412, alpha: 1)], image: UIImage(named: "purrstat")),

      OnboardingSlide(title: "All information stored in Sveti is absolutely private", subtitle: "Records & statistics are saved only on your device and no one has access to them.", globalBackgroundColor: #colorLiteral(red: 0.7450980392, green: 0.9137254902, blue: 0.9098039216, alpha: 1), imageBackgroundGradientColors: [#colorLiteral(red: 0.03921568627, green: 0.7294117647, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0.631372549, blue: 0.8784313725, alpha: 1)], image: UIImage(named: "purrsafe"))
    ]))

    title = "Welcome to Sveti"
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
