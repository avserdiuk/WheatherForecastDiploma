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
    
    private lazy var tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    let time : String = {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let hoursMinutesString = dateFormatter.string(from: date)
        return hoursMinutesString
    }()
    
    private lazy var trademarkView: UIView = {
        let view = AppleWeatherTrademarkView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(tableView)
        view.addSubview(trademarkView)
        
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -55),
            
            trademarkView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 5),
            trademarkView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            trademarkView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            trademarkView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
            
        ])
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
