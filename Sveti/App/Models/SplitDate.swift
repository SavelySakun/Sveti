import RealmSwift
import Foundation

class SplitDate: Object {

  @objc dynamic var yyyy = String()
  @objc dynamic var HHmm = String()
  @objc dynamic var ddMMyyyy = String()
  @objc dynamic var dMMMMyyyy = String()
  @objc dynamic var rawDate = Date()
  private var dateFormatter = DateFormatter()

  convenience init(rawDate: Date) {
    self.init()
    self.rawDate = rawDate
    setYYYY()
    setHHmm()
    setDDmmYYYY()
    setDmmmmYYYY()
  }

  private func setYYYY() {
    dateFormatter.dateFormat = "yyyy"
    yyyy = dateFormatter.string(from: rawDate)
  }

  private func setHHmm() {
    dateFormatter.dateFormat = "HH:mm"
    HHmm = dateFormatter.string(from: rawDate)
  }

  private func setDDmmYYYY() {
    dateFormatter.dateFormat = "dd.MM.yyyy"
    ddMMyyyy = dateFormatter.string(from: rawDate)
  }

  private func setDmmmmYYYY() {
    dateFormatter.dateFormat = "d MMMM yyyy"
    dMMMMyyyy = dateFormatter.string(from: rawDate)
  }
}