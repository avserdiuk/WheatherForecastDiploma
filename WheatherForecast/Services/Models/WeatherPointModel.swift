//
//  Models.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 25.04.2024.
//

import Foundation
import WeatherKit

struct Location {
    let country: String
    let city: String
    let latitude: String
    let longitude: String
}

struct WeatherPoint {
    let location: Location
    let current: CurrentWeather
    let forecastDaily: Forecast<DayWeather>
    let forecastHourly: Forecast<HourWeather>
}
