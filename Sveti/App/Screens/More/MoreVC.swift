import UIKit

class MoreVC: VCwithTable {

  override func setLayout() {
    super.setLayout()
    title = "More"
  }

  override func getDataProvider() -> TableDataProvider? {
    return MoreTableDataProvider()
  }

}

