import Foundation
import DeviceKit

enum DeviceUtils {
  static var isSmallDiagonal: Bool {
    Device.current.diagonal <= 4.7
  }
}

