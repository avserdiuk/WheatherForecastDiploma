//
//  MainViewController.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 23.04.2024.
//

import Foundation
import UIKit
import WeatherKit
import CoreLocation

class MainViewController: UIViewController {
    
    let service = WeatherService()
    
    let time : String = {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let hoursMinutesString = dateFormatter.string(from: date)
        return hoursMinutesString
    }()
    
    private lazy var image : UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "sun")
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    private lazy var locationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Омск"
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    
    private lazy var temperatureLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+30°"
        label.font = UIFont.systemFont(ofSize: 70, weight: .medium)
        return label
    }()
    
    private lazy var conditionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Солнечно"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private lazy var blockInformation : UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(cgColor: CGColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1))
        view.layer.cornerRadius = 11
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var stackInformation1 : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var feelLikeLabel0 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ощущается"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1))
        return label
    }()
    
    private lazy var feelLikeLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+34°"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1))
        return label
    }()
    
    private lazy var stackInformation2 : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var windSpeedLabel0 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ветер"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1))
        return label
    }()
    
    private lazy var windSpeedLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5 м/с"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1))
        return label
    }()
    
    private lazy var stackInformation3 : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var humidityLabel0 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Влажность"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1))
        return label
    }()
    
    private lazy var humidityLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "58%"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1))
        return label
    }()
    
    private lazy var stackInformation4 : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var uvLabel0 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "УФ Индекс"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1))
        return label
    }()
    
    private lazy var uvLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1))
        return label
    }()
    
    private lazy var blockSunsetSunrise : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(cgColor: CGColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1))
        view.layer.cornerRadius = 11
        return view
    }()
    
    private lazy var graphSunsetSunrise : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(cgColor: CGColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1))
        view.image = UIImage(named: "graph")
        return view
    }()
    
    private lazy var blockSunsetSunriseLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ВОСХОД И ЗАКАТ"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1))
        return label
    }()
    
    private lazy var blockSunsetSunriseLenghtDayLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Световой день длится:"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1))
        return label
    }()
    
    private lazy var blockSunsetSunriseLenghtDayLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "13ч 12м"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1))
        return label
    }()
    
    private lazy var sunriseInformation : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var sunriseInformationLabel0 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ВОСХОД"
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1))
        return label
    }()
    
    private lazy var sunriseInformationLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "08:35"
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1))
        return label
    }()
    
    private lazy var sunsetInformation : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var sunsetInformationLabel0 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ЗАКАТ"
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1))
        return label
    }()
    
    private lazy var sunsetInformationLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "20:55"
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1))
        return label
    }()
    
    private lazy var horizontLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Горизонт"
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1))
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(image)
        view.addSubview(locationLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(conditionLabel)
        
        view.addSubview(blockInformation)
        blockInformation.addArrangedSubview(stackInformation1)
        stackInformation1.addArrangedSubview(feelLikeLabel0)
        stackInformation1.addArrangedSubview(feelLikeLabel1)
        
        blockInformation.addArrangedSubview(stackInformation2)
        stackInformation2.addArrangedSubview(windSpeedLabel0)
        stackInformation2.addArrangedSubview(windSpeedLabel1)
        
        blockInformation.addArrangedSubview(stackInformation3)
        stackInformation3.addArrangedSubview(humidityLabel0)
        stackInformation3.addArrangedSubview(humidityLabel1)
        
        blockInformation.addArrangedSubview(stackInformation4)
        stackInformation4.addArrangedSubview(uvLabel0)
        stackInformation4.addArrangedSubview(uvLabel1)
        
        view.addSubview(blockSunsetSunrise)
        blockSunsetSunrise.addSubview(blockSunsetSunriseLabel)
        blockSunsetSunrise.addSubview(graphSunsetSunrise)
        blockSunsetSunrise.addSubview(blockSunsetSunriseLenghtDayLabel)
        blockSunsetSunrise.addSubview(blockSunsetSunriseLenghtDayLabel1)
        
        blockSunsetSunrise.addSubview(sunriseInformation)
        sunriseInformation.addArrangedSubview(sunriseInformationLabel0)
        sunriseInformation.addArrangedSubview(sunriseInformationLabel1)
        
        blockSunsetSunrise.addSubview(sunsetInformation)
        sunsetInformation.addArrangedSubview(sunsetInformationLabel0)
        sunsetInformation.addArrangedSubview(sunsetInformationLabel1)
        blockSunsetSunrise.addSubview(horizontLabel)
        
        NSLayoutConstraint.activate([
            
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 21),
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 0),
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            conditionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 0),
            conditionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            blockInformation.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 30),
            blockInformation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            blockInformation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            blockInformation.heightAnchor.constraint(equalToConstant: 49),
            
            blockSunsetSunrise.heightAnchor.constraint(equalToConstant: 219),
            blockSunsetSunrise.topAnchor.constraint(equalTo: blockInformation.bottomAnchor, constant: 11),
            blockSunsetSunrise.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            blockSunsetSunrise.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            blockSunsetSunriseLabel.leadingAnchor.constraint(equalTo: blockSunsetSunrise.leadingAnchor, constant: 20),
            blockSunsetSunriseLabel.topAnchor.constraint(equalTo: blockSunsetSunrise.topAnchor, constant: 15),
            
            graphSunsetSunrise.leadingAnchor.constraint(equalTo: blockSunsetSunrise.leadingAnchor, constant: 18),
            graphSunsetSunrise.trailingAnchor.constraint(equalTo: blockSunsetSunrise.trailingAnchor, constant: -18),
            graphSunsetSunrise.topAnchor.constraint(equalTo: blockSunsetSunriseLabel.bottomAnchor, constant: 48),
            graphSunsetSunrise.heightAnchor.constraint(equalToConstant: 99),
            
            blockSunsetSunriseLenghtDayLabel.leadingAnchor.constraint(equalTo: blockSunsetSunrise.leadingAnchor, constant: 18),
            blockSunsetSunriseLenghtDayLabel.topAnchor.constraint(equalTo: graphSunsetSunrise.bottomAnchor, constant: 16),
            
            blockSunsetSunriseLenghtDayLabel1.leadingAnchor.constraint(equalTo: blockSunsetSunriseLenghtDayLabel.trailingAnchor, constant: 5),
            blockSunsetSunriseLenghtDayLabel1.topAnchor.constraint(equalTo: graphSunsetSunrise.bottomAnchor, constant: 16),
            
            sunriseInformation.leadingAnchor.constraint(equalTo: graphSunsetSunrise.leadingAnchor, constant: 36),
            sunriseInformation.topAnchor.constraint(equalTo: blockSunsetSunrise.topAnchor, constant: 58),
            
            sunsetInformation.trailingAnchor.constraint(equalTo: graphSunsetSunrise.trailingAnchor, constant: -46),
            sunsetInformation.topAnchor.constraint(equalTo: blockSunsetSunrise.topAnchor, constant: 58),
            
            horizontLabel.trailingAnchor.constraint(equalTo: graphSunsetSunrise.trailingAnchor, constant: -5),
            horizontLabel.topAnchor.constraint(equalTo: graphSunsetSunrise.topAnchor, constant: 54),
            
        ])
        
        getWeather()
    }
    
    
    private func getWeather(){
        Task {
            if let (current, forecastDaily, forecastHourly) = await weather(for: CLLocation(latitude: 54.983334, longitude: 73.366669)) {
                temperatureLabel.text = temperature(Int(current.temperature.value.rounded()))
                conditionLabel.text = getCondition(current.condition)
                
                feelLikeLabel1.text = temperature(Int(current.apparentTemperature.value.rounded()))
                windSpeedLabel1.text = "\(current.wind.speed.converted(to: .metersPerSecond).value.rounded()) м/с"
                humidityLabel1.text = "\(Int(current.humidity.magnitude * 100))%"
                uvLabel1.text = "\(current.uvIndex.value)"
                
                sunriseInformationLabel1.text = dateToTime(forecastDaily[1].sun.sunrise!, format: "HH:mm")
                sunsetInformationLabel1.text = dateToTime(forecastDaily[1].sun.sunset!, format: "HH:mm")
                
                blockSunsetSunriseLenghtDayLabel1.text = getDayLenght(
                    forecastDaily[1].sun.sunset?.timeIntervalSince1970,
                    forecastDaily[1].sun.sunrise?.timeIntervalSince1970
                )
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
    
    private func dateToTime(_ date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let hoursMinutesString = dateFormatter.string(from: date)
        return hoursMinutesString
    }
    
    private func getDayLenght(_ time: TimeInterval?, _ time2: TimeInterval?) -> String {
        
        guard let timeInt = time, let timeInt2 = time2 else { return "error"}
        let myNSDate = Date(timeIntervalSince1970: TimeInterval(timeInt2 - timeInt))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Hч mmм"
        let hoursMinutesString = dateFormatter.string(from: myNSDate)
        return hoursMinutesString
    }
    
    private func temperature(_ temp: Int) -> String {
        if temp > 0 {
            return "+\(temp)°"
        } else {
            return "\(temp)°"
        }
    }
    
    private func getCondition(_ condition: WeatherCondition) -> String {
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
