//
//  MainViewController.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 23.04.2024.
//

import Foundation
import UIKit
import WeatherKit
import CoreLocation

class MainViewController: UIViewController {
    
    var weatherPoint: WeatherPoint?
    
    override func loadView(){
        view = MainScreenView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view().tableView.delegate = self
        view().tableView.dataSource = self
        
    }
    
    private func view() -> MainScreenView {
        return self.view as! MainScreenView
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return 7
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let weatherPoint {
            if indexPath.section == 0 {
                let cell = HeaderViewCell()
                cell.setupWith(weatherPoint)
                return cell
            } else if indexPath.section == 1 {
                let cell = BriefViewCell()
                cell.setupWith(weatherPoint)
                return cell
            } else if indexPath.section == 2 {
                let cell = Block24hViewCell()
                cell.setupWith(weatherPoint)
                return cell
            } else if indexPath.section == 3 {
                let cell = Forecast10dViewCell()
                cell.setupWith(weatherPoint, index: indexPath.item)
                return cell
            } else if indexPath.section == 4 {
                let cell = SunriseSunetViewCell()
                cell.setupWith(weatherPoint)
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            if indexPath.section == 0 {
                return HeaderViewCell()
            } else if indexPath.section == 1 {
                return BriefViewCell()
            } else if indexPath.section == 2 {
                return Block24hViewCell()
            } else if indexPath.section == 3 {
                let cell = Forecast10dViewCell()
                return cell
            } else if indexPath.section == 4 {
                return SunriseSunetViewCell()
            } else {
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Краткая информация"
        } else if section == 2 {
            return "Прогноз на 24 часа"
        } else if section == 3 {
            return "Ежедневный прогноз на 7 дней"
        } else if section == 4 {
            return "Восход и заход солнца"
        } else {
            return nil
        }
        
    }
}
