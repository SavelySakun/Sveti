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

  func getMoodScore(from rawFloat: Float) -> String {
    return String(format: "%.0f", rawFloat)
  }

}
