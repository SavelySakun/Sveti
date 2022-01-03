import UIKit

class TableDataProvider {

  var sections: [TableSection]?

  init(with data: Any? = nil) {
    self.sections = configureSections(with: data)
  }

  func configureSections(with data: Any? = nil) -> [TableSection] {
    return [TableSection(title: "Отредактируй секции в TableDataProvider", cellsData: [])]
  }

  func updateSections(with data: Any? = nil) {
    self.sections = configureSections(with: data)
  }
}
