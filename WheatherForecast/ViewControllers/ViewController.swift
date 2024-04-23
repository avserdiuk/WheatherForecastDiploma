//
//  ViewController.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 23.04.2024.
//

import Foundation
import UIKit
import WeatherKit
import CoreLocation

class ViewController: UIViewController {
    
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
        //label.layer.borderWidth = 1
        return label
    }()
    
    private lazy var feelLikeLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+34°"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1))
        //label.layer.borderWidth = 1
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
        label.text = "РАССВЕТ И ЗАКАТ"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1))
        return label
    }()
    
    private lazy var blockSunsetSunriseLenghtDayLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Световой день:"
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
    
    private lazy var blockSunsetSunriseDayLightLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Оставшийся дневной свет:"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1))
        return label
    }()
    
    private lazy var blockSunsetSunriseDayLightLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "9ч 22м"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1))
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(image)
        view.addSubview(locationLabel)
        view.addSubview(temperatureLabel)
        
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
        blockSunsetSunrise.addSubview(blockSunsetSunriseDayLightLabel)
        blockSunsetSunrise.addSubview(blockSunsetSunriseDayLightLabel1)
        
        NSLayoutConstraint.activate([
            
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 21),
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 0),
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            blockInformation.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 35),
            blockInformation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            blockInformation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            blockInformation.heightAnchor.constraint(equalToConstant: 49),
            
            blockSunsetSunrise.heightAnchor.constraint(equalToConstant: 229),
            blockSunsetSunrise.topAnchor.constraint(equalTo: blockInformation.bottomAnchor, constant: 11),
            blockSunsetSunrise.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            blockSunsetSunrise.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            blockSunsetSunriseLabel.leadingAnchor.constraint(equalTo: blockSunsetSunrise.leadingAnchor, constant: 20),
            blockSunsetSunriseLabel.topAnchor.constraint(equalTo: blockSunsetSunrise.topAnchor, constant: 15),
            
            graphSunsetSunrise.leadingAnchor.constraint(equalTo: blockSunsetSunrise.leadingAnchor, constant: 18),
            graphSunsetSunrise.trailingAnchor.constraint(equalTo: blockSunsetSunrise.trailingAnchor, constant: -18),
            graphSunsetSunrise.topAnchor.constraint(equalTo: blockSunsetSunriseLabel.bottomAnchor, constant: 32),
            graphSunsetSunrise.heightAnchor.constraint(equalToConstant: 99),
            
            blockSunsetSunriseLenghtDayLabel.leadingAnchor.constraint(equalTo: blockSunsetSunrise.leadingAnchor, constant: 18),
            blockSunsetSunriseLenghtDayLabel.topAnchor.constraint(equalTo: graphSunsetSunrise.bottomAnchor, constant: 16),
            
            blockSunsetSunriseLenghtDayLabel1.leadingAnchor.constraint(equalTo: blockSunsetSunriseLenghtDayLabel.trailingAnchor, constant: 5),
            blockSunsetSunriseLenghtDayLabel1.topAnchor.constraint(equalTo: graphSunsetSunrise.bottomAnchor, constant: 16),
            
            blockSunsetSunriseDayLightLabel.leadingAnchor.constraint(equalTo: blockSunsetSunrise.leadingAnchor, constant: 18),
            blockSunsetSunriseDayLightLabel.topAnchor.constraint(equalTo: blockSunsetSunriseLenghtDayLabel.bottomAnchor, constant: 16),
            
            blockSunsetSunriseDayLightLabel1.leadingAnchor.constraint(equalTo: blockSunsetSunriseDayLightLabel.trailingAnchor, constant: 5),
            blockSunsetSunriseDayLightLabel1.topAnchor.constraint(equalTo: blockSunsetSunriseLenghtDayLabel1.bottomAnchor, constant: 16),
            
        ])
        
        getWeather()
    }
    
    
    private func getWeather(){
        Task {
            if let (current, forecastDaily, forecastHourly) = await weather(for: CLLocation(latitude: 54.983334, longitude: 73.366669)) {
                temperatureLabel.text = "\(Int(current.temperature.value.rounded()))°"
                feelLikeLabel1.text = "\(Int(current.apparentTemperature.value.rounded()))°"
                windSpeedLabel1.text = "\(current.wind.speed.converted(to: .metersPerSecond).value.rounded()) м/с"
                humidityLabel1.text = "\(Int(current.humidity.magnitude * 100))%"
                uvLabel1.text = "\(current.uvIndex.value)"
                
                blockSunsetSunriseLenghtDayLabel1.text = "13ч 12м"
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

}
