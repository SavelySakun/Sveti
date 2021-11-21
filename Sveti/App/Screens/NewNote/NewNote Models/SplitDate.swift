import RealmSwift
import Foundation

class SplitDate: Object {

  @objc dynamic var yyyy = String()
  @objc dynamic var HHmm = String()
  @objc dynamic var ddMMyyyy = String()
  @objc dynamic var ddMMyy = String()
  @objc dynamic var dMMMMyyyy = String()
  @objc dynamic var dMM = String()
  @objc dynamic var MM = String()
  @objc dynamic var MMYY = String()

  var endOfDay: Date {
    Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: rawDate) ?? rawDate
  }

  var startOfDay: Date {
    Calendar.current.date(bySettingHour: 0, minute: 0, second: 1, of: rawDate) ?? rawDate
  }

  @objc dynamic var rawDate = Date()

  private var dateFormatter = DateFormatter()

  convenience init(rawDate: Date) {
    self.init()
    self.rawDate = rawDate
    defaultSetup()
  }

  convenience init(ddMMyyyy: String) {
    self.init()
    dateFormatter.dateFormat = "dd.MM.yyyy"
    let rawDate = dateFormatter.date(from: ddMMyyyy)
    self.rawDate = rawDate ?? Date()
    defaultSetup()
  }

  private func defaultSetup() {
    setYYYY()
    setHHmm()
    setDDmmYYYY()
    setDmmmmYYYY()
    setDmm()
    setMM()
    setMMYY()
    setDDmmYY()
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

  private func setDmm() {
    dateFormatter.dateFormat = "d.MM"
    dMM = dateFormatter.string(from: rawDate)
  }

  private func setMM() {
    dateFormatter.dateFormat = "MM"
    MM = dateFormatter.string(from: rawDate)
  }

  private func setMMYY() {
    dateFormatter.dateFormat = "MM.yy"
    MMYY = dateFormatter.string(from: rawDate)
  }

  private func setDDmmYY() {
    dateFormatter.dateFormat = "dd.MM.yy"
    ddMMyy = dateFormatter.string(from: rawDate)
  }
}