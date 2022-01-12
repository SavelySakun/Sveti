import UIKit
import SPAlert

class AppInfoModel: SimpleCellItem {
  override init() {
    super.init()
    accessoryImage = UIImage(named: "copy")
    let appReleaseVersion = Bundle.main.releaseVersionNumber ?? "-"
    let appBundleVersion = Bundle.main.buildVersionNumber ?? "-"
    title = String(format: NSLocalizedString("Sveti app version: %@ (%@)", comment: ""), appReleaseVersion, appBundleVersion)

    onTapAction = {
      UIPasteboard.general.string = self.title
      SPAlert.present(title: "Info copied".localized, preset: .done)
    }
  }
}
