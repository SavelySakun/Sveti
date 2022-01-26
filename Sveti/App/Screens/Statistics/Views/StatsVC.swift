import UIKit
import Charts
import ALPopup

class StatsVC: VCwithTable {

  var popupVC: ALCardController?

  override init(with tableStyle: UITableView.Style = .insetGrouped) {
    super.init(with: tableStyle)

    StatDayContentManager.shared.needUpdateViews = true

    guard let dataProvider = getDataProvider() else { return }
    setViewModel(with: dataProvider)
    tableView = StatsTableView(viewModel: viewModel, style: .insetGrouped)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    guard StatDayContentManager.shared.needUpdateViews else { return }
    updateContent()
  }

  override func logOpenScreenEvent() {
    SvetiAnalytics.log(.Statistics)
  }

  override func updateContent() {
    DispatchQueue.main.async { [self] in
      UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve) {
        StatDayContentManager.shared.updateStatContent {
          viewModel.tableDataProvider?.updateSections()
          tableView.reloadData()
        }
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func getDataProvider() -> TableDataProvider? {
    return StatsTableDataProvider()
  }

  override func setLayout() {
    super.setLayout()
    title = "Statistics".localized
    tableView.backgroundColor = .systemGray6
    setNavigationBar()
  }

  override func setViewModel(with dataProvider: TableDataProvider) {
    viewModel = StatsVM(tableDataProvider: dataProvider)
  }

  private func setNavigationBar() {
    let filterButton = getNavigationButton(imageName: "filterSettings", action: #selector(showStatAverageSettings))
    let helpButton = getNavigationButton(imageName: "help", action: #selector(showHelp))

    navigationItem.setRightBarButtonItems([filterButton, helpButton], animated: false)
  }

  private func getNavigationButton(imageName: String, action: Selector) -> UIBarButtonItem {
    let button = UIButton()
    button.snp.makeConstraints { (make) in
      make.height.width.equalTo(22)
    }
    let filterImage = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
    button.setImage(filterImage, for: .normal)
    button.addTarget(self, action: action, for: .touchUpInside)
    return UIBarButtonItem(customView: button)
  }

  @objc func showStatAverageSettings() {
    let selectStatVC = SelectStatVC()
    selectStatVC.markAsCurrentVC = false
    popupVC = ALPopup.card(controller: selectStatVC)
    popupVC?.push(from: self)
  }

  @objc private func showHelp() {
    let helpWebViewVC = WebViewVC(urlPath: WebViewLinks.detailStatHelp)
    helpWebViewVC.markAsCurrentVC = false
    DispatchQueue.main.async {
      self.present(helpWebViewVC, animated: true, completion: nil)
    }
  }

  func reloadDetailStatSection() {
    makeHapticFeedback()
    DispatchQueue.main.async { [self] in
      tableView.reloadSections(IndexSet(integer: 1), with: .fade)
    }
  }
}
