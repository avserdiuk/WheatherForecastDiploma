//
//  NetworkManager.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 24.04.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init(){}
    
    func getCoordsWith(_ location: String, complition: @escaping (String)->()){
        
        guard let url = URL(string: "https://geocode-maps.yandex.ru/1.x/?apikey=01b486f3-711c-44fd-aa4e-8ec2904d303b&geocode=omsk&format=json") else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: URLRequest(url: url)) { data, responce, error in
            
        }
        
        complition(location)
    }
}

struct Location {
    let name : String
    let latitude: Double
    let longitude: Double
}
