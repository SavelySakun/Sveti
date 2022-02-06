import Foundation
import RealmSwift

class Mood: Object {
  @objc dynamic var emotionalState: Double = 6.0
  @objc dynamic var physicalState: Double = 6.0
  @objc dynamic var average: Double {
    SvetiMath().average([emotionalState, physicalState])
  }
}
