import UIKit

class SelectGroupVC: VCwithTable {

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    view.snp.makeConstraints { (make) in
      make.height.equalTo(tableView.contentSize.height + 30.0)
    }
  }

  init() {
    super.init(with: .insetGrouped)

  }

  override func getDataProvider() -> TableDataProvider? {
    return SelectGroupTableDataProvider()
  }

  override func setLayout() {
    super.setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
