import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    RealmHelper.shared.configureRealm()
    UISetup()
    dataSetup()
		return true
	}

	// MARK: UISceneSession Lifecycle
	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}

  // MARK: Setup
  private func UISetup() {
    IQKeyboardManager.shared.enable = true
  }

  private func dataSetup() {
    TagsRepository().saveDefaultTags()
    StatSettingsRepository().saveDefaultSettings()
  }
}
