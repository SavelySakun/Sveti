import UIKit

class LinkToSiteModel: ISimpleCellItem {
  var title: String

  var iconImage: UIImage?
  var iconTintColor: UIColor?
  var iconBackgroundColor: UIColor?
  var accessoryImage: UIImage? = UIImage(named: "globe")

  var onTapAction: (() -> Void)?

  init() {

    title = "What's new & Roadmap".localized

    onTapAction = {
      let notionLink = "https://sava.notion.site/Sveti-e10863a20154429db4b5bd866a4d4b38"
      guard let url = URL(string: notionLink) else { return }
      UIApplication.shared.open(url)
    }
  }
}
