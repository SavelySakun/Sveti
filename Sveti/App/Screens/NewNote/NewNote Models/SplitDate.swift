import Foundation
import RealmSwift

enum DateFormats: String {
    case yyyy
    case HHmm = "HH:mm"
    case ddMMyyyy = "dd.MM.yyyy"
    case ddMMyy = "dd.MM.yy"
    case dMMMMyyyy = "d MMMM yyyy"
    case dMMMM = "d MMMM"
    case dMM = "d.MM"
    case MM
    case MMYY = "MM.yy"
    case weekday = "EEEE"
}

class SplitDate: Object {
    @objc dynamic var rawDate = Date()
    @objc dynamic var yyyy: String { getDate(with: .yyyy) }
    @objc dynamic var HHmm: String { getDate(with: .HHmm) }
    @objc dynamic var ddMMyyyy: String { getDate(with: .ddMMyyyy) }
    @objc dynamic var ddMMyy: String { getDate(with: .ddMMyy) }
    @objc dynamic var dMMMMyyyy: String { getDate(with: .dMMMMyyyy) }
    @objc dynamic var dMMMM: String { getDate(with: .dMMMM) }
    @objc dynamic var dMM: String { getDate(with: .dMM) }
    @objc dynamic var MM: String { getDate(with: .MM) }
    @objc dynamic var MMYY: String { getDate(with: .MMYY) }
    @objc dynamic var weekday: String { getDate(with: .weekday) }

    var endOfDay: Date {
        Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: rawDate) ?? rawDate
    }

    var startOfDay: Date {
        Calendar.current.date(bySettingHour: 0, minute: 0, second: 1, of: rawDate) ?? rawDate
    }

    private var dateFormatter = DateFormatter()

    convenience init(rawDate: Date) {
        self.init()
        self.rawDate = rawDate
    }

    convenience init(ddMMyyyy: String) {
        self.init()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let rawDate = dateFormatter.date(from: ddMMyyyy)
        self.rawDate = rawDate ?? Date()
    }

    private func getDate(with format: DateFormats) -> String {
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: rawDate)
    }
}
