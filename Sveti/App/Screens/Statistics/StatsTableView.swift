import UIKit

class StatsTableView: TableView {

  override func configureTable() {
    self.tableHeaderView = StatsTableHeaderView(frame: .init(x: 0, y: 0, width: frame.width, height: 100))
  }

}
