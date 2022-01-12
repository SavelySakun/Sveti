import Foundation
import UIKit

class BackupTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {
    guard let backupInfo = data as? BackupInfo else { return getDefaultTableSectons() }

    var tableSections = getDefaultTableSectons()
    let cellType = SimpleCell.self

    switch backupInfo.state {
    case .needToCheckBackupExistence: break
    case .readyToRestoreBackup, .successRestoreData, .successBackupedToCloud:
      guard let date = backupInfo.lastBackupDate else { break }
      tableSections[0].cellsData[0] = getBackupCellData(backupDate: date)
    case .noBackupFound: break
    case .noInternetConnection:
      tableSections = getInactiveDefaultCells()
      let item = WarningBackupItem()
      item.title = "No internet access"
      item.subtitle = "Please check your device settings"
      tableSections.insert(TableSection(title: "", cellsData: [
        CellData(type: cellType, viewModel: CellVM(cellValue: item))
      ]), at: 0)
    case .needToAuthInICloud:
      tableSections = getInactiveDefaultCells()
      let item = WarningBackupItem()
      item.title = "Need to log in to iCloud"
      item.subtitle = "You can do this in the device settings"
      tableSections.insert(TableSection(title: "", cellsData: [
        CellData(type: cellType, viewModel: CellVM(cellValue: item))
      ]), at: 0)
    }

    return tableSections
  }

  private func getDefaultTableSectons() -> [TableSection] {
    let cellType = SimpleCell.self
    let tableSections = [
      TableSection(title: "", cellsData: [
        CellData(type: cellType, viewModel: CellVM(cellValue: BackupToCloudCellItem())),
        CellData(type: cellType, viewModel: CellVM(cellValue: RestoreFromCloudCellItem()))
      ])
    ]
    return tableSections
  }

  func configureColorForSubtitle(dateOfLastBackup: Date) -> UIColor {
    let calendar = Calendar.current

    // Replace the hour (time) of both dates with 00:00
    let date1 = calendar.startOfDay(for: dateOfLastBackup)
    let date2 = calendar.startOfDay(for: Date())

    let components = calendar.dateComponents([.day], from: date1, to: date2)
    guard let daysPassed = components.day else { return .systemGray2 }
    switch daysPassed {
      case 0...7:
      return #colorLiteral(red: 0.2049866915, green: 0.6625028849, blue: 0.5520762801, alpha: 1)
      case 8...30:
      return .orange
      case 31...10000:
      return .systemRed
      default:
      return .systemGray2
    }
  }

  private func getBackupCellData(backupDate: Date) -> CellData {
    let item = BackupToCloudCellItem()
    let date = SplitDate(rawDate: backupDate)
    item.title = "Save current data to the cloud"
    item.subtitle = "Last backup: \(date.dMMMMyyyy), \(date.HHmm)"
    item.subtitleColor = configureColorForSubtitle(dateOfLastBackup: backupDate)

    return CellData(type: SimpleCell.self, viewModel: CellVM(cellValue: item))
  }

  private func getInactiveDefaultCells() -> [TableSection] {
    let cellType = SimpleCell.self
    let backupItem = BackupToCloudCellItem()
    let restoreItem = RestoreFromCloudCellItem()
    [backupItem, restoreItem].forEach { item in
      item.isActive = false
      item.titleColor = .systemGray3
      item.subtitleColor = .systemGray4
      item.backgroundColor = .white.withAlphaComponent(0.5)
      item.accessoryTintColor = .systemGray5
    }

    let tableSections = [
      TableSection(title: "", cellsData: [
        CellData(type: cellType, viewModel: CellVM(cellValue: backupItem)),
        CellData(type: cellType, viewModel: CellVM(cellValue: restoreItem))
      ])
    ]
    return tableSections
  }
}
