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
    
    override func loadView() {
        self.view = StartScreenView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view().table.delegate = self
        view().table.dataSource = self
        view().searchBar.delegate = self
        
        getStartItems()
        
    }
    
    private func view() -> StartScreenView {
        return self.view as! StartScreenView
    }
    
    private func getStartItems(){
        CoreDataManager.shared.getLocations { location in
            
            guard let location else {
                self.view().welcomeView.isHidden = false
                return
            }
            
            location.forEach {
                WeatherManager.shared.getWeatherAt($0) { weatherPoint in
                    DispatchQueue.main.async {
                        self.weatherPoints.insert(weatherPoint, at: 0)
                        self.view().table.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                        self.view().table.reloadData()
                        
                        UIView.animate(withDuration: 2.5) {
                            self.view().welcomeView.isHidden = true
                            self.view().table.isHidden = false
                        }
                    }
                }
            }
        }
    }
    
    
    private func existAlert(){
        let alert = UIAlertController(title: "Ошибка", message: "Такая локация уже добавлена", preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}

extension StartViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let locationName = searchBar.text else { return }
        
        UIView.animate(withDuration: 2.5) {
            self.view().welcomeView.isHidden = true
            self.view().table.isHidden = false
        }
        
        NetworkManager.shared.getCoordsWith(locationName){ location in
            CoreDataManager.shared.addLocation(location){ result in
                guard result else {
                    DispatchQueue.main.async {
                        self.existAlert()
                    }
                    return
                }
                WeatherManager.shared.getWeatherAt(location) { weatherPoint in
                    DispatchQueue.main.async {
                        self.weatherPoints.insert(weatherPoint, at: 0)
                        self.view().table.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                        self.view().searchBar.text = .none
                    }
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
            self.view().table.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = MainViewController()
        controller.weatherPoint = weatherPoints[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
