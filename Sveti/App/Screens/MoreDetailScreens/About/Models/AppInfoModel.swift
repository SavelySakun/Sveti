import SPAlert
import UIKit

class AppInfoModel: SimpleCellItem {
    override init() {
        super.init()
        accessoryImage = UIImage(named: "copy")
        let appReleaseVersion = Bundle.main.releaseVersionNumber ?? "-"
        let appBundleVersion = Bundle.main.buildVersionNumber ?? "-"
        title = String(format: NSLocalizedString("Sveti app version: %@ (%@)", comment: ""), appReleaseVersion, appBundleVersion)

        onTapAction = { _ in
            UIPasteboard.general.string = self.title
            SPAlert.present(title: "Info copied".localized, preset: .done)
        }
    }
}
