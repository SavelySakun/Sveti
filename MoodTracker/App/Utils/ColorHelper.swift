import UIKit

class ColorHelper {

  enum Palette {
    case general
    case background
  }

  private let backgroundColors: [UIColor] = [#colorLiteral(red: 0.9882352941, green: 0.8901960784, blue: 0.968627451, alpha: 1), .systemGray6, #colorLiteral(red: 0.8901960784, green: 0.9882352941, blue: 0.9215686275, alpha: 1)]
  private let generalColors: [UIColor] = [#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1), #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)]

  func getColor(value: Int, alpha: CGFloat = 0.5, palette: Palette = .general ) -> UIColor {
    var color: UIColor = .white
    let palette = (palette == .general) ? generalColors : backgroundColors
    switch value {
    case 0...4:
      color = palette[0]
    case 5...7:
      color = palette[1]
    case 8...10:
      color = palette[2]
    default:
      color = palette[1]
    }
    return color.withAlphaComponent(alpha)
  }
}
