import Foundation
import RealmSwift

class StatDay: Object, Dated {
  var date: Date {
    return splitDate?.rawDate ?? Date()
  }

  @objc dynamic var splitDate: SplitDate? = SplitDate(rawDate: Date())
  @objc dynamic var totalNotes: Double {
    Double(phyzicalStates.count)
  }

  var phyzicalStates = List<Double>()
  var emotionalStates = List<Double>()

  convenience init(splitDate: SplitDate = SplitDate(rawDate: Date()), phyzicalStates: [Double], emotionalStates: [Double]) {
    self.init()
    self.splitDate = splitDate
    self.phyzicalStates.append(objectsIn: phyzicalStates)
    self.emotionalStates.append(objectsIn: emotionalStates)
  }
}
