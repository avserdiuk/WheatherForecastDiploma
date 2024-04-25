//
//  StartViewController.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 24.04.2024.
//

import Foundation
import UIKit

class StartViewController: UIViewController {
    
    var locations: [Location] = []
    //private var points : [String] = []
    
    private lazy var searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.searchBarStyle = .minimal
        bar.placeholder = "Поиск локации"
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.delegate = self
        return bar
    }()
    
    private lazy var table: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(table)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            searchBar.heightAnchor.constraint(equalToConstant: 46),
            
            table.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
        
    }
}

extension StartViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let location = searchBar.text else { return }
       // points = []
        NetworkManager.shared.getCoordsWith(location){ location in
            
            DispatchQueue.main.async {

                self.locations.insert(location, at: 0)
                self.table.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                self.searchBar.text = .none
                
//                self.locations.forEach { location in
//                    self.points.append(location.city)
//                }
//                
//                UserDefaults().setValue(self.points, forKey: "points")
            }
        }
    }
}

extension StartViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTableViewCell()
        cell.setup(location: locations[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        self.locations.remove(at: indexPath.row)
        self.table.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(MainViewController(), animated: true)
    }
}
