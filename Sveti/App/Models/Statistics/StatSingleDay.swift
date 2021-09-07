import Foundation
import RealmSwift

class StatSingleDay: Object  {
  @objc dynamic var date: Date = Date()
  @objc dynamic var totalNotes: Float = 0.0
  @objc dynamic var averageEmotionalState: Float = 0.0
  @objc dynamic var averagePhysicalState: Float = 0.0
  @objc dynamic var averageMood: Float {
    getAverage()
  }

  private func getAverage() -> Float {
    let allValues = [averageEmotionalState, averagePhysicalState]
    var total: Float = 0
    allValues.forEach { total += $0 }
    return total / Float(allValues.count)
  }

  func updateData(emotional: Float, pzyz: Float) {

  }
}
