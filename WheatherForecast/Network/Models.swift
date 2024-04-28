//
//  Models.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 25.04.2024.
//

import Foundation

struct Location {
    let country: String
    let city: String
    let latitude: String
    let longitude: String
    var temperature: String?
    var condition: String?
    var feelLike: String?
    var windSpeed: String?
    var humidity: String?
    var uv: String?
    
}
