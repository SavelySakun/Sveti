import UIKit
import Charts

class StatisticsVC: VCwithTable {

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func getDataProvider() -> TableDataProvider? {
    return StatisticsTableDataProvider()
  }

  override func setLayout() {
    super.setLayout()
    title = "Statistics"
  }
}
