import UIKit

class ColorHelper {

  private let chartColors: [UIColor] = [#colorLiteral(red: 0.3882352941, green: 0.2784313725, blue: 0.3019607843, alpha: 1), #colorLiteral(red: 0.6666666667, green: 0.5607843137, blue: 0.4, alpha: 1), #colorLiteral(red: 0.9764705882, green: 0.2549019608, blue: 0.2666666667, alpha: 1), #colorLiteral(red: 0.9882352941, green: 0.4823529412, blue: 0.1333333333, alpha: 1), #colorLiteral(red: 1, green: 0.7058823529, blue: 0, alpha: 1), #colorLiteral(red: 0.7215686275, green: 0.768627451, blue: 0.9019607843, alpha: 1), #colorLiteral(red: 0.4588235294, green: 0.5568627451, blue: 0.8039215686, alpha: 1), #colorLiteral(red: 0.7058823529, green: 0.4784313725, blue: 0.9176470588, alpha: 1), #colorLiteral(red: 0.4705882353, green: 0.737254902, blue: 0.3803921569, alpha: 1), #colorLiteral(red: 0.1882352941, green: 0.7725490196, blue: 1, alpha: 1)]

  func getColor(value: Int, alpha: CGFloat = 0.5) -> UIColor {
    guard value >= 0 && value <= 10 else { return .systemGray3 }
    return chartColors[value].withAlphaComponent(alpha)
  }
}
