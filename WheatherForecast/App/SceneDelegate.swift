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

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)



        //UserDefaults.standard.set([], forKey: "Locations")

//        print(param)
//        print(UserDefaults.standard.object(forKey: "Locations"))

        if param == false {
            rootController = PermissionViewController()
            UserDefaults.standard.set(true, forKey: "isFirstOpenApp")
        } else {
            rootController = PageViewController()

        }

        window?.rootViewController = UINavigationController(rootViewController: rootController ?? UIViewController())
        window?.makeKeyAndVisible()

    }

}

