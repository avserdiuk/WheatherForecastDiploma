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

class WeatherManager{
    
    static let shared = WeatherManager()
    let service = WeatherService()
    
    private init(){}
    
    
    func getWeatherAt(_ location: Location, complition: @escaping (CurrentWeather)->()){
        Task {
            if let (current, forecastDaily, forecastHourly) = await weather(for: CLLocation(latitude: Double(location.latitude) ?? 0, longitude: Double(location.longitude) ?? 0)) {
//                temperatureLabel.text = temperature(Int(current.temperature.value.rounded()))
//                conditionLabel.text = getCondition(current.condition)
//                
//                feelLikeLabel1.text = temperature(Int(current.apparentTemperature.value.rounded()))
//                windSpeedLabel1.text = "\(current.wind.speed.converted(to: .metersPerSecond).value.rounded()) м/с"
//                humidityLabel1.text = "\(Int(current.humidity.magnitude * 100))%"
//                uvLabel1.text = "\(current.uvIndex.value)"
//                
//                sunriseInformationLabel1.text = dateToTime(forecastDaily[1].sun.sunrise!, format: "HH:mm")
//                sunsetInformationLabel1.text = dateToTime(forecastDaily[1].sun.sunset!, format: "HH:mm")
//                
//                blockSunsetSunriseLenghtDayLabel1.text = getDayLenght(
//                    forecastDaily[1].sun.sunset?.timeIntervalSince1970,
//                    forecastDaily[1].sun.sunrise?.timeIntervalSince1970
//                )
                complition(current)
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
        let myNSDate = Date(timeIntervalSince1970: TimeInterval(timeInt2 - timeInt))
        
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
    
    func getCondition(_ condition: WeatherCondition) -> String {
        switch condition {
        case .blizzard:
            return "Метель"
        case .blowingDust:
            return "Пыльно"
        case .blowingSnow:
            return "Метель"
        case .breezy:
            return "Прохладно"
        case .clear:
            return "Ясно"
        case .cloudy:
            return "Облачно"
        case .drizzle:
            return "Мелкий дождь"
        case .flurries:
            return "Шквалистый ветер"
        case .foggy:
            return "Тумано"
        case .freezingDrizzle:
            return "Изморозь"
        case .freezingRain:
            return "Ледяной дождь"
        case .frigid:
            return "Холодно"
        case .hail:
            return "Град"
        case .haze:
            return "Туман"
        case .heavyRain:
            return "Ливень"
        case .heavySnow:
            return "Снегопад"
        case .hot:
            return "Жарко"
        case .hurricane:
            return "Ураган"
        case .isolatedThunderstorms:
            return "Местами грозы"
        case .mostlyClear:
            return "Преимущественно ясно"
        case .mostlyCloudy:
            return "Преимущественно облачно"
        case .partlyCloudy:
            return "Местами облачно"
        case .rain:
            return "Дождь"
        case .scatteredThunderstorms:
            return "Рассеянные грозы"
        case .sleet:
            return "Мокрый снег"
        case .smoky:
            return "Думан"
        case .snow:
            return "Снег"
        case .strongStorms:
            return "Сильный шторм"
        case .sunFlurries:
            return ""
        case .sunShowers:
            return ""
        case .thunderstorms:
            return "Гроза"
        case .tropicalStorm:
            return "Тропическая буря"
        case .windy:
            return "Ветрено"
        case .wintryMix:
            return "Зимний микс"
        default:
            return ""
        }
    }
}

