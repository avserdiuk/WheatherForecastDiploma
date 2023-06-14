//
//  PermissionViewController.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 20.03.2023.
//

import UIKit
import CoreLocation

class PermissionViewController: UIViewController {

    private lazy var locationManager : CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()

    override func loadView() {
        self.view = PermissionView()
        view().acceptButton.addTarget(self, action: #selector(didTapAcceptButton), for: .touchUpInside)
        view().declineButton.addTarget(self, action: #selector(didTapDeclineButton), for: .touchUpInside)
    }

    func view() -> PermissionView {
        return self.view as! PermissionView
    }

    @objc func didTapAcceptButton(){
        locationManager.requestAlwaysAuthorization()
    }

    @objc func didTapDeclineButton(){
        navigationController?.pushViewController(PageViewController(), animated: true)
    }
}


extension PermissionViewController : CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .denied, .restricted:
            print("Определение локации невозможно")
        case .notDetermined:
            print("Определение локации не запрошено")
        @unknown default:
            fatalError()
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {

        if let location = locations.first {
            let lon = location.coordinate.longitude
            let lat = location.coordinate.latitude

            NetworkManager().getDescriptionWithCoords((lat,lon)) { desc in
                DispatchQueue.main.async {
                    UserDefaults.standard.set([desc], forKey: "Locations")
                    self.navigationController?.pushViewController(PageViewController(), animated: true)
                }
            }
        } else {
            print("Не удалось получить координаты")
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
    }
}
