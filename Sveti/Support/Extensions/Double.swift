import Foundation

extension Double {
  func toInt() -> Int {
    return Int(self)
  }

  func round1f() -> Double {
    let rounded = String(format:"%.1f", self)
    return Double(rounded) ?? self
  }
}
