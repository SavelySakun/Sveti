import Foundation
import SigmaSwiftStatistics

class SvetiMath {

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

  func getString(from rawDouble: Double, digits: Int = 1) -> String {
    let score = String(format: "%.\(digits)f", rawDouble)
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

  func calculateStability(from data: [Double]) -> Double? {
    guard let standardDeviationSample = Sigma.standardDeviationSample(data),
          let average = Sigma.average(data) else { return nil }

    let proportionOfDeviationFromAverage = standardDeviationSample / average
    if proportionOfDeviationFromAverage < 0 || proportionOfDeviationFromAverage > 1 {
      return 0.0 // <– if negative stability return 0.0
    } else {
      let percentageOfStability = (1 - proportionOfDeviationFromAverage) * 100
      return percentageOfStability
    }
  }

  func calculatePercentageChange(from value1: Double, value2: Double) -> Double {
    let difference = (value2 - value1)
    let percentageChange = (difference / value1) * 100
    return percentageChange
  }

}
