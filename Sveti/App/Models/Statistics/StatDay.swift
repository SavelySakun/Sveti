import Foundation
import RealmSwift

class StatDay: Object  {
  @objc dynamic var splitDate: SplitDate? = SplitDate(rawDate: Date())
  @objc dynamic var totalNotes: Float = 0.0
  var phyzicalStates = List<Float>()
  var emotionalStates = List<Float>()
}
