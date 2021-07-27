import Foundation

class MathHelper {

  func getAverageMood(from note: Note) -> String {
    let average = (note.phys + note.mood) / 2
    let score = String(format: "%.1f", average)

    if score.last == "0" {
      let newScore = score.dropLast(2)
      return String(newScore)
    } else {
      return score
    }
  }

  func getAverageMood(from note: Note) -> Int {
    let average = (note.phys + note.mood) / 2
    return Int(average)
  }

}
