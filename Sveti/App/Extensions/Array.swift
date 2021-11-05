import Foundation

extension Array {
  /** Возвращает из массива опциональное значение */
  subscript(safe index: Int) -> Element? {
    guard startIndex <= index && index < endIndex else {
      return nil
    }
    return self[index]
  }
}
