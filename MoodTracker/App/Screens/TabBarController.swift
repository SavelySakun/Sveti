import UIKit

class TabBarController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setTabbarItems()
  }

  func setTabbarItems() {

    let diaryController = createNavigationController(
      vc: DiaryVC(),
      image: getIcon(named: Constants.ImageNames.Tabbar.diaryIcon),
      selectedImage: getIcon(named: Constants.ImageNames.Tabbar.diarySelected),
      tabBarTitle: "Дневник"
    )

    let newNoteController = createNavigationController(
      vc: NewNoteVC(),
      image: getIcon(named: Constants.ImageNames.Tabbar.newNote),
      selectedImage: getIcon(named: Constants.ImageNames.Tabbar.newNoteSelected),
      tabBarTitle: "Новая запись"
    )

    viewControllers = [diaryController, newNoteController]
  }

  private func createNavigationController(vc: UIViewController, image: UIImage?, selectedImage: UIImage?, tabBarTitle: String) -> UINavigationController {
    let viewController = vc
    let navigationController = UINavigationController(rootViewController: viewController)

    if let image = image, let selectedImage = selectedImage {
      navigationController.tabBarItem.image = image
      navigationController.tabBarItem.selectedImage = selectedImage
    }

    navigationController.title = tabBarTitle
    return navigationController
  }

  private func getIcon(named: String) -> UIImage? {
    return UIImage(named: named)?.imageResized(to: .init(width: 24, height: 24))
  }

}

