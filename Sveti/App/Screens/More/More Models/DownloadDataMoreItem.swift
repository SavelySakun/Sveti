import UIKit

class DownloadDataMoreItem: IMoreItem {
  var title: String = "Download data"
  var iconBackgroundColor: UIColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
  var iconImage: UIImage? = UIImage(named: "download")?.withRenderingMode(.alwaysTemplate)
  var iconTintColor: UIColor = .white
  var onTapAction: (() -> Void)?

  init() {
    setOnTapAction()
  }

  private func setOnTapAction() {
    onTapAction = {
      guard let currentVC = CurrentVC.current else { return }
      let contactDeveloperVC = ContactDeveloperVC()
      currentVC.navigationController?.pushViewController(contactDeveloperVC, animated: true)
    }
  }
}