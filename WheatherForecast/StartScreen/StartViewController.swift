//
//  StartViewController.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 24.04.2024.
//

import Foundation
import UIKit

class StartViewController: UIViewController {
    
    var weatherPoints: [WeatherPoint] = []
    
    private lazy var searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.searchBarStyle = .minimal
        bar.placeholder = "Поиск локации"
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.delegate = self
        return bar
    }()
    
    private lazy var welcomeView: UIView = {
        let view = WelcomeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private lazy var table: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.isHidden = true
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    private lazy var trademarkView: UIView = {
        let view = AppleWeatherTrademarkView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(searchBar)
        view.addSubview(welcomeView)
        view.addSubview(table)
        view.addSubview(trademarkView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            searchBar.heightAnchor.constraint(equalToConstant: 46),
            
            welcomeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            welcomeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            table.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -55),
            
            trademarkView.topAnchor.constraint(equalTo: table.bottomAnchor, constant: 5),
            trademarkView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            trademarkView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            trademarkView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        getStartItems()
        
    }
    
    func getStartItems(){
        CoreDataManager.shared.getLocations { location in
            
            guard let location else {
                self.welcomeView.isHidden = false
                return
            }
            
            location.forEach {
                    WeatherManager.shared.getWeatherAt($0) { weatherPoint in
                        DispatchQueue.main.async {
                            self.weatherPoints.insert(weatherPoint, at: 0)
                            self.table.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                            self.table.reloadData()
                            
                            UIView.animate(withDuration: 2.5) {
                                self.welcomeView.isHidden = true
                                self.table.isHidden = false
                            }
                        }
                    }
            }
        }
    }
    
    
}

extension StartViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let locationName = searchBar.text else { return }
        
        UIView.animate(withDuration: 2.5) {
            self.welcomeView.isHidden = true
            self.table.isHidden = false
        }
        
        NetworkManager.shared.getCoordsWith(locationName){ location in
            CoreDataManager.shared.addLocation(location)
            WeatherManager.shared.getWeatherAt(location) { weatherPoint in
                DispatchQueue.main.async {
                    self.weatherPoints.insert(weatherPoint, at: 0)
                    self.table.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                    self.searchBar.text = .none
                }
            }
        }
    }
}

extension StartViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherPoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTableViewCell()
        cell.setup(weatherPoint: weatherPoints[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.shared.removeItem(weatherPoints[indexPath.row].location)
            self.weatherPoints.remove(at: indexPath.row)
            self.table.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = MainViewController()
        controller.weatherPoint = weatherPoints[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
