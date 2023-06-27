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
    let lastTimeUpdate = UserDefaults.standard.integer(forKey: "lastTimeUpdate")

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        CoreDataManager.shared.reloadLocationList()

//        print("lastTimeUpdate  - ",lastTimeUpdate)
//        let nowTime = Int(NSDate().timeIntervalSince1970)
//        print("nowTime - ",nowTime)
//        print("n - l ", nowTime - lastTimeUpdate)

//        if (lastTimeUpdate != 0) && ((nowTime - lastTimeUpdate) > 60) {
//
//            CoreDataManager.shared.locations.forEach { point in
//                NetworkManager().getWheater(coordinates: (Double(point.latitude), Double(point.longitude))) { wheather in
//                    CoreDataManager.shared.updateLocation(location: point, wheather: wheather) {
//                        print("update location finish")
//                        let time = Int(NSDate().timeIntervalSince1970)
//                        print("nowTime - ",time)
//                        UserDefaults.standard.set(time, forKey: "lastTimeUpdate")
//
//                        DispatchQueue.main.async {
//                            self.checkParam()
//                        }
//                    }
//                }
//            }
//        } else {
//            checkParam()
//        }


        // чекаем время последнего обновления
        // создаем массив из данных что нужны для получения погоды
        // зануляем базу
        // запрашиваем погоду и вновь заполняем базу
        // обновляем данные на экране

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

