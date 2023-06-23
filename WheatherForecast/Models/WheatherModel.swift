//
//  Wheather.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 28.03.2023.
//

import Foundation

struct Wheather : Codable {
    let fact: Fact
    let forecasts : [Forecast]
}

struct Fact : Codable {
    let temp: Int
    let windSpeed: Double
    let condition: String
    let cloudness : Double // облачность
    let humidity : Double // влажность

    enum CodingKeys: String, CodingKey {
        case temp
        case windSpeed = "wind_speed"
        case condition
        case cloudness
        case humidity
    }
}

struct Forecast: Codable {
    let date : String
    let unixtime : Int
    let sunrise : String?
    let sunset : String?
    let parts: Parts
    let hours : [Hours]

    enum CodingKeys: String, CodingKey {
        case date
        case unixtime = "date_ts"
        case sunrise
        case sunset
        case parts
        case hours
    }
}

struct Parts: Codable {
    let night, day: Day
}

struct Day: Codable {
    let tempMin: Int
    let tempMax: Int
    let tempAvg: Int
    let tempFeelLike: Int
    let condition : String
    let precipitation : Double
    let windSpeed : Double
    let windDir : String
    let cloudness: Double
    let uvIndex: Int?

    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case tempAvg = "temp_avg"
        case tempFeelLike = "feels_like"
        case condition
        case precipitation = "prec_strength"
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case cloudness
        case uvIndex = "uv_index"
    }
}

struct Hours : Codable {
    let temp : Int
    let feelsLike : Int
    let hour : String
    let condition : String
    let windSpeed : Double
    let windDir : String
    let precipitation : Double
    let cloudness: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case hour
        case condition
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case precipitation = "prec_strength"
        case cloudness

    }
}

