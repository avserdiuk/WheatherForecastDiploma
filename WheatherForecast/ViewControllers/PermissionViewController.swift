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

    // Устанавливаем вью в качестве основного вью этого контроллера и назнаем таргеты на кнопки
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

        // для введенной локации запрашиваем погоду и записываем к базу данных
        if let location = locations.first {
            let lon = location.coordinate.longitude
            let lat = location.coordinate.latitude

            NetworkManager().getDescriptionWithCoords((lat,lon)) { locationName in
                NetworkManager().getWheater(coordinates: (lat, lon)) { wheather in
                    CoreDataManager.shared.addLocation(name: locationName, longitude: Float(lon), latitude: Float(lat), wheather: wheather) {

                        DispatchQueue.main.async {
                            self.navigationController?.pushViewController(PageViewController(), animated: true)
                        }
                    }
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
