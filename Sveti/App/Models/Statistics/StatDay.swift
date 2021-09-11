import Foundation
import RealmSwift

class StatDay: Object  {
  @objc dynamic var date = String() // saving "dd.MM.yyyy"
  @objc dynamic var totalNotes: Float = 0.0
  var phyzicalStates = List<Float>()
  var emotionalStates = List<Float>()
}

class DrawableStatDay {
  var date = Date()
  var averageEmotional: Float = 0.0
  var averagePhysical: Float = 0.0
  var averageState: Float = 0.0
}
