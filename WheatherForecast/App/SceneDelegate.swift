//
//  SceneDelegate.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 20.03.2023.
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    //var points = UserDefaults.standard.object(forKey: "points") as? [String]
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
//        var locations : [Location] = []
//        
//        if let points {
//            points.forEach { point in
//                NetworkManager.shared.getCoordsWith(point) { location in
//                    locations.append(location)
//                    
//                }
//            }
//        }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: StartViewController())
        window?.makeKeyAndVisible()
        
        

        

    }
    

}

