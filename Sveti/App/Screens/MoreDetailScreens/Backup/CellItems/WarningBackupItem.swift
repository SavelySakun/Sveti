import UIKit

class WarningBackupItem: SimpleCellItem {
  override init() {
    super.init()
    iconImage = UIImage(named: "warning")?.withRenderingMode(.alwaysOriginal)
    isActive = false
    accessoryImage = UIImage(named: "info")?.withRenderingMode(.alwaysTemplate)
  }
}
