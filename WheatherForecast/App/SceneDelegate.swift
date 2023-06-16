//
//  SceneDelegate.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 20.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var rootController: UIViewController?
    let param = UserDefaults.standard.bool(forKey: "isFirstOpenApp") // default = false
    var userSettings: Settings?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        //UserDefaults.standard.set([], forKey: "Locations")

        if param == false {
            // если произошел первый запуск приложения, то:

            UserDefaults.standard.set(true, forKey: "isFirstOpenApp")
            UserDefaults.standard.set([true, false, false, true], forKey: "settings") // default settings

            rootController = PermissionViewController()
        } else {
            // если приложение уже открывали, то:
            rootController = PageViewController()
        }

        window?.rootViewController = UINavigationController(rootViewController: rootController ?? UIViewController())
        window?.makeKeyAndVisible()

    }

}

