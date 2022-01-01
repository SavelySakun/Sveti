import UIKit
import SPAlert

class AppInfoModel: ISimpleCellItem {

  var title: String

  var iconImage: UIImage? = nil
  var iconTintColor: UIColor? = nil
  var iconBackgroundColor: UIColor? = nil

  var onTapAction: (() -> Void)?

  init() {
    let appReleaseVersion = Bundle.main.releaseVersionNumber ?? "-"
    let appBundleVersion = Bundle.main.buildVersionNumber ?? "-"
    title = "Sveti App: \(appReleaseVersion) (\(appBundleVersion)) ⚙️"

    onTapAction = {
      UIPasteboard.general.string = self.title
      SPAlert.present(title: "Info copied", preset: .done)
    }
  }
}
