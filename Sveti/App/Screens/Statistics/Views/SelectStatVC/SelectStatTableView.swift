import UIKit
import RealmSwift

class SelectStatTableView: TableView {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let statType = StatTypes(rawValue: indexPath.row) ?? .averageEmotionalAndPhysical
    StatSettingsRepository().updateStatType(statType)
    SvetiAnalytics.log(.selectTypeOfAverageStat)
    guard let statDaysVC = CurrentVC.current as? StatsVC else { return }
    statDaysVC.popupVC?.dismiss(animated: true) {
      statDaysVC.updateContent()
    }
  }
}
