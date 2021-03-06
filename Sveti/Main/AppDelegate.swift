import UIKit
import IQKeyboardManagerSwift
import Firebase
import FirebaseAnalytics

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    RealmHelper().configureRealm()
    UISetup()
    dataSetup()
    firebaseSetup()

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
    UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
  }

  private func dataSetup() {
    TagsRepository().saveDefaultTags()
    StatSettingsRepository().saveDefaultSettings()
  }

  private func firebaseSetup() {
    FirebaseApp.configure()
    #if targetEnvironment(simulator)
    Analytics.setAnalyticsCollectionEnabled(false)
    #endif
    Analytics.logEvent(AnalyticsEventAppOpen, parameters: nil)
  }
}
