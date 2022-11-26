import Foundation

class DetailStatCellVM: CellVM {
    private let statMaker = DetailStatDataMaker()
    private let periodStatItems: [DetailStatItem]

    init() {
        periodStatItems = statMaker.getPeriodItems()
        super.init()
        cellValue = periodStatItems
        setBarSelectionObserver()
    }

    private func setBarSelectionObserver() {
        let notifName = NotificationNames.onStatBarSelect
        NotificationCenter.default.addObserver(self, selector: #selector(onBarSelect(notification:)), name: notifName, object: nil)
    }

    @objc private func onBarSelect(notification: NSNotification) {
        if let index = notification.userInfo?["barIndex"] as? Int {
            cellValue = statMaker.getItemsForSelectedBar(at: index)
        } else {
            cellValue = periodStatItems
        }
        guard let currentVC = CurrentVC.current as? StatsVC else { return }
        currentVC.reloadDetailStatSection()
    }
}
