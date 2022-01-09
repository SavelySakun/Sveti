import UIKit
import DeviceKit

enum DeviceUtils {
  static var isSmallDiagonal: Bool {
    Device.current.diagonal <= 4.7
  }

  static var isPortraitOrientation: Bool {
    Device.current.orientation == .portrait
  }
}

