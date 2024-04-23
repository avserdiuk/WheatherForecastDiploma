//
//  SceneDelegate.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 20.03.2023.
//

import UIKit
import CoreData

import WeatherKit
import CoreLocation


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var rootController: UIViewController?
    let param = UserDefaults.standard.bool(forKey: "isFirstOpenApp") // default = false

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

       // let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Constants.appGroupID)!
//        let storeURL = containerURL.appendingPathComponent("WheatherForecast.sqlite")
//        let description = NSPersistentStoreDescription(url: storeURL)

//        let container = NSPersistentContainer(name: "WheatherForecast")
//        container.persistentStoreDescriptions = [description]
//        container.loadPersistentStores { NSPersistentStoreDescription, Error in
//            print("NSP - ", NSPersistentStoreDescription)
//            print("NSPE - ", Error ?? "no error")
//        }

        window = UIWindow(windowScene: windowScene)

        // Обновляем список локаций из базы
        CoreDataManager.shared.reloadLocationList()

        // Проверка на первый запуск приложения
        if param == false {
            // если произошел первый запуск приложения, то:

            UserDefaults.standard.set(true, forKey: "isFirstOpenApp")
            UserDefaults.standard.set([true, false, false, false], forKey: "settings") // default settings

            rootController = PermissionViewController()
        } else {
            // если приложение уже открывали, то:
            rootController = PageViewController()
        }

        window?.rootViewController = UINavigationController(rootViewController: rootController ?? UIViewController())
        window?.makeKeyAndVisible()


    }
    
    

    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataManager.shared.saveContext()
        }
}

