import UIKit

class TableDataProvider {
    var sections: [TableSection]?

    init(with data: Any? = nil) {
        sections = configureSections(with: data)
    }

    func configureSections(with _: Any? = nil) -> [TableSection] {
        return [TableSection(title: "Отредактируй секции в TableDataProvider", cellsData: [])]
    }

    func updateSections(with data: Any? = nil) {
        sections = configureSections(with: data)
    }
}
