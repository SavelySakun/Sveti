import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
    let startViewController = EditTagGroupVC(groupId: "37D2A8CE-F652-46F0-BA81-E56A3AC2A056")
		window.rootViewController = startViewController
		self.window = window
		window.makeKeyAndVisible()
	}

}
