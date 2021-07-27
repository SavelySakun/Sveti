import UIKit

class ColorHelper {

  private let colors = [#colorLiteral(red: 0.6823529412, green: 0, blue: 0.07843137255, alpha: 1), #colorLiteral(red: 0.7098039216, green: 0.1843137255, blue: 0, alpha: 1), #colorLiteral(red: 0.7176470588, green: 0.2980392157, blue: 0, alpha: 1), #colorLiteral(red: 0.7098039216, green: 0.3960784314, blue: 0, alpha: 1), #colorLiteral(red: 0.6862745098, green: 0.4862745098, blue: 0, alpha: 1), #colorLiteral(red: 0.6470588235, green: 0.5725490196, blue: 0, alpha: 1), #colorLiteral(red: 0.5882352941, green: 0.6588235294, blue: 0, alpha: 1), #colorLiteral(red: 0.5019607843, green: 0.7411764706, blue: 0, alpha: 1), #colorLiteral(red: 0.3764705882, green: 0.8196078431, blue: 0.1333333333, alpha: 1), #colorLiteral(red: 0.3764705882, green: 0.8196078431, blue: 0.1333333333, alpha: 1), #colorLiteral(red: 0.03529411765, green: 0.8941176471, blue: 0.3294117647, alpha: 1)]

  func getColor(value: Int, alpha: CGFloat = 0.5) -> UIColor {
    return colors[value].withAlphaComponent(alpha)
  }

}
