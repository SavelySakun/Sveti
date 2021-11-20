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

protocol Dated {
  var date: Date { get }
}

extension Array where Element: Dated {
  func groupedBy(dateComponents: Set<Calendar.Component>) -> [Date: [Element]] {
    let initial: [Date: [Element]] = [:]
    let groupedByDateComponents = reduce(into: initial) { accumulated, element in
      let dateComponents = Calendar.current.dateComponents(dateComponents, from: element.date)
      let date = Calendar.current.date(from: dateComponents)!
      let existingElements = accumulated[date] ?? []
      accumulated[date] = existingElements + [element]
    }
    return groupedByDateComponents
  }
}
