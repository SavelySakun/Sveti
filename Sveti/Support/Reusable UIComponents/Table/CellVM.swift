import UIKit

class CellVM {
    var title: String?
    var subtitle: String?
    var cellValue: Any?

    init(title: String? = nil, subtitle: String? = nil, cellValue: Any? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.cellValue = cellValue
    }
}
