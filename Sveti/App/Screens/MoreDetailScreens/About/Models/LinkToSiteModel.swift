import UIKit

class LinkToSiteModel: SimpleCellItem {
  override init() {
    super.init()
    title = "What's new & Roadmap".localized
    accessoryImage = UIImage(named: "globe")

    onTapAction = { _ in
      let notionLink = "https://sava.notion.site/Sveti-e10863a20154429db4b5bd866a4d4b38"
      guard let url = URL(string: notionLink) else { return }
      UIApplication.shared.open(url)
    }
  }
}
