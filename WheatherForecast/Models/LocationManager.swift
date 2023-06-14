////
////  LocationManager.swift
////  WheatherForecast
////
////  Created by Алексей Сердюк on 31.03.2023.
////
//
//import Foundation
//import CoreLocation
//
//class LocationManager {
//
//    private lazy var locationManager : CLLocationManager = {
//        let manager = CLLocationManager()
//        return manager
//    }()
//
//    func getRequest(){
//        locationManager.requestAlwaysAuthorization()
//    }
//
//    func getStatus(){
//        print(locationManager.authorizationStatus.rawValue)
//    }
//
//    func getPosition(){
//        locationManager.requestLocation()
//    }
//}
