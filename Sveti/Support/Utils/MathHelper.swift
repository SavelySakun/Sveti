import Foundation

class MathHelper {

  func getAverageMood(from note: Note) -> String {
    guard let average = note.mood?.average else { return "Error with math helper" }
    let score = String(format: "%.1f", average)

    if score.last == "0" {
      let newScore = score.dropLast(2)
      return String(newScore)
    } else {
      return score
    }
  }

  func getAverageMood(from note: Note) -> Int {
    guard let averageMood = note.mood?.average else { return 404 }
    return Int(averageMood)
  }

  func getMoodScore(from rawFloat: Double, digits: Int = 1) -> String {

    let score = String(format: "%.\(digits)f", rawFloat)

    if score.count > 1 && score.last == "0" {
      let newScore = score.dropLast(2)
      return String(newScore)
    } else {
      return score
    }
  }

  func average<T: Numeric & Comparable & FloatingPoint>(_ values: [T]) -> T {
    var total: T = T(0)

    values.forEach { value in
      total += value
    }

    return total / T(values.count)
  }
}
