import UIKit

class ColorHelper {

  private let chartColors: [UIColor] = [#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0.2549019608, green: 0.2745098039, blue: 0.3019607843, alpha: 1), #colorLiteral(red: 0.3333333333, green: 0.04705882353, blue: 0.09411764706, alpha: 1), #colorLiteral(red: 0.9764705882, green: 0.2235294118, blue: 0.2352941176, alpha: 1), #colorLiteral(red: 0.9450980392, green: 0.3882352941, blue: 0.01568627451, alpha: 1), #colorLiteral(red: 0.831372549, green: 0.6196078431, blue: 0.1294117647, alpha: 1), #colorLiteral(red: 0.6196078431, green: 0.4823529412, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.4666666667, green: 0.5647058824, blue: 0.8117647059, alpha: 1), #colorLiteral(red: 0.6862745098, green: 0.4470588235, blue: 0.9137254902, alpha: 1), #colorLiteral(red: 0.4235294118, green: 0.7137254902, blue: 0.3294117647, alpha: 1), #colorLiteral(red: 0.03921568627, green: 0.7294117647, blue: 1, alpha: 1)]

  func getColor(value: Int, alpha: CGFloat = 0.5) -> UIColor {
    guard value >= 0 && value <= 10 else { return .systemGray3 }
    return chartColors[value].withAlphaComponent(alpha)
  }
}
