import UIKit
import SPAlert

class AppInfoModel: ISimpleCellItem {

  var title: String

  var iconImage: UIImage? = nil
  var iconTintColor: UIColor? = nil
  var iconBackgroundColor: UIColor? = nil
  var accessoryImage: UIImage? = UIImage(named: "copy")

  var onTapAction: (() -> Void)?

  init() {
    let appReleaseVersion = Bundle.main.releaseVersionNumber ?? "-"
    let appBundleVersion = Bundle.main.buildVersionNumber ?? "-"
    title = String(format: NSLocalizedString("Sveti app version: %@ (%@)", comment: ""), appReleaseVersion, appBundleVersion)

    onTapAction = {
      UIPasteboard.general.string = self.title
      SPAlert.present(title: "Info copied".localized, preset: .done)
    }
  }
}
