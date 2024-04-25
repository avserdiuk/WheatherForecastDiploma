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
    
    func getCoordsWith(_ location: String, complition: @escaping (Location)->()){
        
        guard let url = URL(string: "https://geocode-maps.yandex.ru/1.x/?apikey=01b486f3-711c-44fd-aa4e-8ec2904d303b&geocode=\(location)&format=json") else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: URLRequest(url: url)) { data, responce, error in
 
            guard let data else { return }
            
            do {
                let json = try JSONDecoder().decode(GeoDecoder.self, from: data)
                let coordinate = json.response.geoObjectCollection.featureMember.first?.geoObject.point?.pos?.components(separatedBy: " ")
                let location = Location(
                    country: json.response.geoObjectCollection.featureMember.first?.geoObject.description ?? "-",
                    city: json.response.geoObjectCollection.featureMember.first?.geoObject.name ?? "-",
                    latitude: coordinate?[1] ?? "-",
                    longitude: coordinate?[0] ?? "-")
                complition(location)
            } catch {
                print(error)
            }
            
        }.resume()
        
        
    }
}
