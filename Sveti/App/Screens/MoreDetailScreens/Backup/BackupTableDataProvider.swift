import Foundation
import UIKit

class BackupTableDataProvider: TableDataProvider {

  override func configureSections(with data: Any? = nil) -> [TableSection] {
    let configurator = BackupTableSectionsConfigurator()
    guard let backupInfo = data as? BackupInfo else { return configurator.getTableSections(backupState: .needToCheckBackupExistence)}
    let tableSections = configurator.getTableSections(backupState: backupInfo.state, backupDate: backupInfo.lastBackupDate)
    return tableSections
  }
}

class BackupTableSectionsConfigurator {

  func getTableSections(backupState: BackupState, backupDate: Date? = nil) -> [TableSection] {
    switch backupState {

    case .needToCheckBackupExistence:
      return [defaultTableSection, deleteBackupSection]

    case .readyToRestoreBackup, .successDataRestore, .successBackupedToCloud:
      guard let date = backupDate else { return [defaultTableSection] }
      return [defaultSectionWithBackupInfo(backupDate: date), deleteBackupSection]

    case .noBackupFound, .backupDeleted:
      return [noBackupFoundSection, inactiveRestoreSection]

    case .noInternetConnection:
      return [noInternetAccessSection, inactiveDefaultTableSection]

    case .needToAuthInICloud:
      return [needAuthICloudSection, inactiveDefaultTableSection]
    }
  }

  private let title = "Actions"

  lazy var defaultTableSection: TableSection = TableSection(title: title, cellsData: [
        CellData(type: SimpleCell.self, viewModel: CellVM(cellValue: BackupToCloudCellItem())),
        CellData(type: SimpleCell.self, viewModel: CellVM(cellValue: RestoreFromCloudCellItem()))
      ])

  lazy var inactiveDefaultTableSection: TableSection = TableSection(title: title, cellsData: [
    CellData(type: SimpleCell.self, viewModel: CellVM(cellValue: getInactive(item: BackupToCloudCellItem()))),
    CellData(type: SimpleCell.self, viewModel: CellVM(cellValue: getInactive(item:RestoreFromCloudCellItem())))
  ])

  lazy var inactiveRestoreSection: TableSection = TableSection(title: title, cellsData: [
      CellData(type: SimpleCell.self, viewModel: CellVM(cellValue: BackupToCloudCellItem())),
      CellData(type: SimpleCell.self, viewModel: CellVM(cellValue: getInactive(item: RestoreFromCloudCellItem())))
    ])

  lazy var deleteBackupSection = TableSection(title: "Danger zone", cellsData: [
      CellData(type: SimpleCell.self, viewModel: CellVM(cellValue: DeleteBackupCellItem()))
    ])

  lazy var noInternetAccessSection: TableSection = getWarningSection(title: "No internet access", subtitle: "Please check your device settings")

  lazy var needAuthICloudSection: TableSection = getWarningSection(title: "Need to log in to iCloud", subtitle: "You can do this in the device settings")

  lazy var noBackupFoundSection: TableSection = getWarningSection(title: "Cloud backup not found", subtitle: "Create your first backup")

  func defaultSectionWithBackupInfo(backupDate: Date) -> TableSection {
    let item = BackupToCloudCellItem()
    let date = SplitDate(rawDate: backupDate)
    item.subtitle = "Last backup: \(date.dMMMMyyyy), \(date.HHmm)"
    item.subtitleColor = getColorByDayPassed(dateOfLastBackup: backupDate)

    return TableSection(
      title: title,
      cellsData: [
        CellData(type: SimpleCell.self, viewModel: CellVM(cellValue: item)),
        CellData(type: SimpleCell.self, viewModel: CellVM(cellValue: RestoreFromCloudCellItem()))
      ])
  }

  private func getWarningSection(title: String, subtitle: String?) -> TableSection {
    let item = WarningBackupItem()
    item.title = title
    item.subtitle = subtitle
    return TableSection(
      title: "",
      cellsData: [
        CellData(type: SimpleCell.self, viewModel: CellVM(cellValue: item))
      ])
  }

  private func getColorByDayPassed(dateOfLastBackup: Date) -> UIColor {
    guard let daysPassed = calculateDaysPassed(dateOfLastBackup: dateOfLastBackup) else { return .systemGray2 }

    switch daysPassed {
    case 0...7:
      return #colorLiteral(red: 0.2049866915, green: 0.6625028849, blue: 0.5520762801, alpha: 1)
    case 8...30:
      return .orange
    default:
      return .systemRed
    }
  }

  private func calculateDaysPassed(dateOfLastBackup: Date) -> Int? {
    let calendar = Calendar.current

    // Replace the hour (time) of both dates with 00:00
    let date1 = calendar.startOfDay(for: dateOfLastBackup)
    let date2 = calendar.startOfDay(for: Date())

    let components = calendar.dateComponents([.day], from: date1, to: date2)
    return components.day
  }

  private func getInactive(item: SimpleCellItem) -> SimpleCellItem {
    item.isActive = false
    item.titleColor = .systemGray3
    item.subtitleColor = .systemGray4
    item.backgroundColor = .white.withAlphaComponent(0.5)
    item.accessoryTintColor = .systemGray5
    return item
  }
}
