import UIKit

class TableDataProvider {

  var sections: [TableSection]?

  init() {
    self.sections = configureSections()
  }

  func configureSections() -> [TableSection] {
    return [TableSection]()
  }

}
