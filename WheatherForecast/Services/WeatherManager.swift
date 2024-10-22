//
//  WeatherManager.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 29.04.2024.
//

import Foundation
import UIKit
import WeatherKit
import CoreLocation

enum ConditionImage: String{
    case clearSky
    case fewClouds
    case scatteredClouds
    case brokenClouds
    case showerRain
    case rain
    case thunderstorm
    case snow
    case mist
}

class WeatherManager{
    
    static let shared = WeatherManager()
    let service = WeatherService()
    
    private init(){}
    
    func getWeatherAt(_ location: Location, complition: @escaping (WeatherPoint)->()){
        Task {
            if let (current, forecastDaily, forecastHourly) = await weather(for: CLLocation(latitude: Double(location.latitude) ?? 0, longitude: Double(location.longitude) ?? 0)) {
                
                let weatherPoint = WeatherPoint(
                    location: location,
                    current: current,
                    forecastDaily: forecastDaily,
                    forecastHourly: forecastHourly
                )
                complition(weatherPoint)
            }
        }
    }
    
    private func weather(for location: CLLocation) async -> (CurrentWeather, Forecast<DayWeather>, Forecast<HourWeather>)? {
      let currentWeather = await Task.detached(priority: .userInitiated) {
        let forecast = try? await self.service.weather(
          for: location,
          including: .current, .daily, .hourly)
        return forecast
      }.value
      return currentWeather
    }
    
    func dateToTime(_ date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let hoursMinutesString = dateFormatter.string(from: date)
        return hoursMinutesString
    }
    
    func getDayLenght(_ time: TimeInterval?, _ time2: TimeInterval?) -> String {
        guard let timeInt = time, let timeInt2 = time2 else { return "error"}
        let myNSDate = Date(timeIntervalSince1970: timeInt-timeInt2-60*60*6)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Hч mmм"
        let hoursMinutesString = dateFormatter.string(from: myNSDate)
        return hoursMinutesString
    }
    
    func temperature(_ temp: Int) -> String {
        if temp > 0 {
            return "+\(temp)°"
        } else {
            return "\(temp)°"
        }
    }
    
    func getCondition(_ condition: WeatherCondition) -> (String, String) {
        switch condition {
//        case .blizzard:
//            return "Метель"
//        case .blowingDust:
//            return "Пыльно"
//        case .blowingSnow:
//            return "Метель"
//        case .breezy:
//            return "Прохладно"
        case .clear:
            return ("Ясно", "sun")
        case .cloudy:
            return ("Облачно", "cloud")
        case .drizzle:
            return ("Мелкий дождь", "rain")
//        case .flurries:
//            return "Шквалистый ветер"
//        case .foggy:
//            return "Тумано"
//        case .freezingDrizzle:
//            return "Изморозь"
//        case .freezingRain:
//            return "Ледяной дождь"
//        case .frigid:
//            return "Холодно"
//        case .hail:
//            return "Град"
//        case .haze:
//            return "Туман"
        case .heavyRain:
            return ("Ливень", "rain")
//        case .heavySnow:
//            return "Снегопад"
//        case .hot:
//            return "Жарко"
//        case .hurricane:
//            return "Ураган"
//        case .isolatedThunderstorms:
//            return "Местами грозы"
        case .mostlyClear:
            return ("Ясная погода", "sun")
        case .mostlyCloudy:
            return ("Облачно","sunCloud")
        case .partlyCloudy:
            return ("Местами облачно","sunCloud")
        case .rain:
            return ("Дождь", "rain")
//        case .scatteredThunderstorms:
//            return "Рассеянные грозы"
//        case .sleet:
//            return "Мокрый снег"
//        case .smoky:
//            return "Думан"
//        case .snow:
//            return "Снег"
//        case .strongStorms:
//            return "Сильный шторм"
//        case .sunFlurries:
//            return ""
//        case .sunShowers:
//            return ""
//        case .thunderstorms:
//            return "Гроза"
//        case .tropicalStorm:
//            return "Тропическая буря"
//        case .windy:
//            return "Ветрено"
//        case .wintryMix:
//            return "Зимний микс"
        default:
            return ("\(condition.rawValue)","" )
        }
    }
}

