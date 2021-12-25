import UIKit
import RealmSwift

class SelectStatTableView: TableView {

  private let realm = try! Realm()

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let statType = StatTypes(rawValue: indexPath.row)
    try! realm.write {
      StatSettingsManager.shared.settings.statType = statType ?? .averageEmotionalAndPhysical
    }
    SvetiAnalytics.log(.selectTypeOfAverageStat)
    guard let statDaysVC = CurrentVC.current as? StatsVC else { return }
    statDaysVC.popupVC?.dismiss(animated: true) {
      statDaysVC.updateContent()
    }
  }
}
