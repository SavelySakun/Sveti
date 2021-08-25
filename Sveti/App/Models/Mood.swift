import Foundation
import RealmSwift

class Mood: Object {
  @objc dynamic var emotionalState: Float = 6.0
  @objc dynamic var physicalState: Float = 6.0
  @objc dynamic var average: Float {
    getAverage()
  }

  private func getAverage() -> Float {
    let allValues = [emotionalState, physicalState]
    var total: Float = 0
    allValues.forEach { total += $0 }
    return total / Float(allValues.count)
  }
}
