import Foundation

enum DetailStatType {
    case date, max, min, average, change, stability, totalNotes
}

class DetailStatItem {
    let type: DetailStatType
    let iconName: String
    let title: String
    var value: String

    init(type: DetailStatType, iconName: String, title: String, value: String? = nil) {
        self.type = type
        self.iconName = iconName
        self.title = title
        self.value = value ?? "-"
    }
}
