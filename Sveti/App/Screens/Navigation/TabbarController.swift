import UIKit

class TabbarController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setTabbarItems()
    selectedIndex = 0
    delegate = self
  }

  func setTabbarItems() {
    let diaryController = createNavigationController(
      vc: DiaryVC(),
      image: getIcon(named: Constants.ImageNames.Tabbar.diaryIcon),
      selectedImage: getIcon(named: Constants.ImageNames.Tabbar.diarySelected),
      tabBarTitle: "Diary"
    )

    let statisticsController = createNavigationController(
      vc: StatsVC(),
      image: getIcon(named: Constants.ImageNames.Tabbar.statistics),
      selectedImage: getIcon(named: Constants.ImageNames.Tabbar.statisticsFilled),
      tabBarTitle: "Statistics",
      largeTitle: false)

    let newNoteVC = UIViewController()
    let newNoteItem = UITabBarItem(
      title: "New note",
      image: getIcon(named: Constants.ImageNames.Tabbar.newNote),
      selectedImage: getIcon(named: Constants.ImageNames.Tabbar.newNoteSelected)
    )
    newNoteVC.tabBarItem = newNoteItem

    let moreController = createNavigationController(
      vc: MoreVC(),
      image: getIcon(named: Constants.ImageNames.Tabbar.more),
      selectedImage: getIcon(named: Constants.ImageNames.Tabbar.more),
      tabBarTitle: "More"
    )

    viewControllers = [diaryController, newNoteVC, statisticsController, moreController]
  }

  private func createNavigationController(vc: UIViewController, image: UIImage?, selectedImage: UIImage?, tabBarTitle: String, largeTitle: Bool = true) -> UINavigationController {
    let viewController = vc
    let navigationController = UINavigationController(rootViewController: viewController)

    if let image = image, let selectedImage = selectedImage {
      navigationController.tabBarItem.image = image
      navigationController.tabBarItem.selectedImage = selectedImage
    }

    navigationController.navigationBar.prefersLargeTitles = largeTitle
    navigationController.title = tabBarTitle
    return navigationController
  }

  private func getIcon(named: String) -> UIImage? {
    return UIImage(named: named)?.imageResized(to: .init(width: 24, height: 24))
  }

}

extension TabbarController: UITabBarControllerDelegate {

  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

    guard let selectedTabItemIndex = viewControllers?.firstIndex(of: viewController) else {
      return true
    }

    if selectedTabItemIndex == 1 {
      let newNoteVC = NewNoteVC()
      newNoteVC.markAsCurrentVC = false
      let newNoteController = UINavigationController(rootViewController: newNoteVC)
      present(newNoteController, animated: true, completion: nil)
      return false
    }

    return true
  }
}
