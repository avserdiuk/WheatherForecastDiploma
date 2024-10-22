//
//  NetworkManager.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 27.03.2023.
//

import Foundation
import WeatherKit
import CoreLocation

class NetworkManager {
    
    let urlSession = URLSession.shared
    
    func getDescriptionWithCoords(_ coords: (Double, Double), complition: @escaping (String)->()){
        let rawUrl = "https://geocode-maps.yandex.ru/1.x/?format=json&apikey=01b486f3-711c-44fd-aa4e-8ec2904d303b&geocode=\(coords.1),\(coords.0)"
        guard let url = URL(string: rawUrl) else { return }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            guard let data else { return }
            
            do {
                let result = try JSONDecoder().decode(GeoDecoder.self, from: data)
                let description = result.response.geoObjectCollection.featureMember.first?.geoObject.description ?? ""
                
                complition(description)
            } catch {
                print(#function, error)
            }
            
        }
        task.resume()
        
    }
    
    func getCoordsWithString(_ city : String,  complition: @escaping (String,(Double,Double)) -> ()) {
        
        if let encode = (city as NSString).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
            guard let url = URL(string: "https://geocode-maps.yandex.ru/1.x/?format=json&apikey=01b486f3-711c-44fd-aa4e-8ec2904d303b&geocode=\(encode)") else { return }
            let task = urlSession.dataTask(with: url) { data, response, error in
                guard let data else { return }
                
                do {
                    let result = try JSONDecoder().decode(GeoDecoder.self, from: data)
                    let country = result.response.geoObjectCollection.featureMember.first?.geoObject.description ?? ""
                    let name = result.response.geoObjectCollection.featureMember.first?.geoObject.name ?? ""
                    let description = name + ", " + country
                    
                    let response = result.response.geoObjectCollection.featureMember.first?.geoObject.point!.pos
                    if let answer = response?.components(separatedBy: " ") {
                        let lat = Double(answer[1])!
                        let lon = Double(answer[0])!
                        let coords = (lat, lon)
                        complition(description, coords)
                    }
                    
                } catch {
                    print(#function, error)
                }
            }
            
            task.resume()
        }
    }
    
    func getWheater(coordinates: (lat: Double,lon: Double), complition: @escaping (_ forecast : Wheather) -> ()) {
        
        guard let url = URL(string: "https://api.weather.yandex.ru/v2/forecast?lat=\(coordinates.lat)&lon=\(coordinates.lon)&hours=true") else { return }
        
        var request = URLRequest(url: url)
        request.addValue("df6d2f54-9221-4eef-922a-1a0dffb6660d", forHTTPHeaderField: "X-Yandex-API-Key")
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            
            guard let data else { return }
            
            guard let resp = response as? HTTPURLResponse else { return }
            
            do {
                let result = try JSONDecoder().decode(Wheather.self, from: data)
                complition(result)
            } catch {
                print(#function, error)
            }
            
        }
        task.resume()
    }
    
    func getWeather(coordinates: (lat: Double,lon: Double), complition: @escaping (_ forecast : Wheather) -> ()) {
        Task {
            await doAsyncWork(coordinates: coordinates)
        }
        
    }
    
    func doAsyncWork(coordinates: (lat: Double,lon: Double)) async {
        
        let service = WeatherService.shared
        let response = try? await service.weather(
            for: CLLocation.init(latitude: coordinates.lat, longitude:  coordinates.lon),
            including: .current, .daily)
        
    }
    
}
