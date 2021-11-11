import Foundation
import RealmSwift

class StatSettings: Object {
  @objc dynamic var minimumDate = SplitDate(ddMMyyyy: "01.01.2015").endOfDay
  @objc dynamic var maximumDate = SplitDate(rawDate: Date()).endOfDay
  @objc dynamic var groupingType: GroupingType = .day
}
