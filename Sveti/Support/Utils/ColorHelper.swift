import UIKit

class ColorHelper {
    enum ColorsPalette {
        case chart, tag
    }

    private let chartColors: [Int: UIColor] = [0: #colorLiteral(red: 0.2705882353, green: 0.3333333333, blue: 0.3803921569, alpha: 1), 1: #colorLiteral(red: 0.2705882353, green: 0.3333333333, blue: 0.3803921569, alpha: 1), 2: #colorLiteral(red: 0.6705882353, green: 0.02745098039, blue: 0.1019607843, alpha: 1), 3: #colorLiteral(red: 0.6705882353, green: 0.02745098039, blue: 0.1019607843, alpha: 1), 4: #colorLiteral(red: 0.9450980392, green: 0.3882352941, blue: 0.01568627451, alpha: 1), 5: #colorLiteral(red: 0.9450980392, green: 0.3882352941, blue: 0.01568627451, alpha: 1), 6: #colorLiteral(red: 0.8117647059, green: 0.2352941176, blue: 0.6549019608, alpha: 1), 7: #colorLiteral(red: 0.03921568627, green: 0.7294117647, blue: 1, alpha: 1), 8: #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1), 9: #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.3333333333, alpha: 1), 10: #colorLiteral(red: 0.137254902, green: 0.6588235294, blue: 0.4862745098, alpha: 1)]

    // Looks exactly as chartColors but not the same
    private let tagsBackColors: [Int: UIColor] = [0: #colorLiteral(red: 0.2666666667, green: 0.3254901961, blue: 0.3725490196, alpha: 1), 1: #colorLiteral(red: 0.2666666667, green: 0.3254901961, blue: 0.3725490196, alpha: 1), 2: #colorLiteral(red: 0.6156862745, green: 0.02745098039, blue: 0.09411764706, alpha: 1), 3: #colorLiteral(red: 0.6156862745, green: 0.02745098039, blue: 0.09411764706, alpha: 1), 4: #colorLiteral(red: 0.8666666667, green: 0.3529411765, blue: 0.01176470588, alpha: 1), 5: #colorLiteral(red: 0.8666666667, green: 0.3529411765, blue: 0.01176470588, alpha: 1), 6: #colorLiteral(red: 0.768627451, green: 0.1921568627, blue: 0.6156862745, alpha: 1), 7: #colorLiteral(red: 0, green: 0.6862745098, blue: 0.9607843137, alpha: 1), 8: #colorLiteral(red: 0.1176470588, green: 0.6823529412, blue: 0.3058823529, alpha: 1), 9: #colorLiteral(red: 0.1176470588, green: 0.6823529412, blue: 0.3058823529, alpha: 1), 10: #colorLiteral(red: 0.1215686275, green: 0.5960784314, blue: 0.4392156863, alpha: 1)]

    func getColor(value: Int, alpha: CGFloat = 1.0, palette: ColorsPalette = .chart) -> UIColor {
        let palette = (palette == .chart) ? chartColors : tagsBackColors
        let color = palette[value] ?? .systemGray3
        return color.withAlphaComponent(alpha)
    }
}
