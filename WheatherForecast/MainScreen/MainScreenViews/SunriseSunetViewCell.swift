//
//  Section2ViewCell.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 29.04.2024.
//

import Foundation
import UIKit

class SunriseSunetViewCell: UITableViewCell {
    
    private lazy var blockSunsetSunrise : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "backgroundSecondary")
        view.layer.cornerRadius = 11
        return view
    }()
    
    private lazy var graphSunsetSunrise : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "backgroundSecondary")
        view.image = UIImage(named: "graph")
        return view
    }()
    
    
    private lazy var blockSunsetSunriseLenghtDayLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Световой день длится:"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1))
        return label
    }()
    
    private lazy var blockSunsetSunriseLenghtDayLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "13ч 12м"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
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
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1))
        return label
    }()
    
    private lazy var sunriseInformationLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "08:35"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
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
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1))
        return label
    }()
    
    private lazy var sunsetInformationLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "20:55"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(blockSunsetSunrise)
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
        
            blockSunsetSunrise.topAnchor.constraint(equalTo: super.topAnchor, constant: 0),
            blockSunsetSunrise.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 0),
            blockSunsetSunrise.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: 0),
            blockSunsetSunrise.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: 0),
            
            graphSunsetSunrise.topAnchor.constraint(equalTo: blockSunsetSunrise.topAnchor, constant: 30),
            graphSunsetSunrise.leadingAnchor.constraint(equalTo: blockSunsetSunrise.leadingAnchor, constant: 18),
            graphSunsetSunrise.trailingAnchor.constraint(equalTo: blockSunsetSunrise.trailingAnchor, constant: -18),
            graphSunsetSunrise.heightAnchor.constraint(equalToConstant: 99),
            
            blockSunsetSunriseLenghtDayLabel.leadingAnchor.constraint(equalTo: blockSunsetSunrise.leadingAnchor, constant: 18),
            blockSunsetSunriseLenghtDayLabel.topAnchor.constraint(equalTo: graphSunsetSunrise.bottomAnchor, constant: 16),
            
            blockSunsetSunriseLenghtDayLabel1.leadingAnchor.constraint(equalTo: blockSunsetSunriseLenghtDayLabel.trailingAnchor, constant: 5),
            blockSunsetSunriseLenghtDayLabel1.topAnchor.constraint(equalTo: graphSunsetSunrise.bottomAnchor, constant: 16),
            blockSunsetSunriseLenghtDayLabel1.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: -10),
            
            sunriseInformation.leadingAnchor.constraint(equalTo: graphSunsetSunrise.leadingAnchor, constant: 33),
            sunriseInformation.topAnchor.constraint(equalTo: blockSunsetSunrise.topAnchor, constant: 10),
            
            sunsetInformation.trailingAnchor.constraint(equalTo: graphSunsetSunrise.trailingAnchor, constant: -43),
            sunsetInformation.topAnchor.constraint(equalTo: blockSunsetSunrise.topAnchor, constant: 10),
            
            horizontLabel.trailingAnchor.constraint(equalTo: graphSunsetSunrise.trailingAnchor, constant: 0),
            horizontLabel.topAnchor.constraint(equalTo: graphSunsetSunrise.topAnchor, constant: 54),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWith(_ weatherPoint: WeatherPoint){
        sunriseInformationLabel1.text = WeatherManager.shared.dateToTime(weatherPoint.forecastDaily[1].sun.sunrise!, format: "HH:mm")
        sunsetInformationLabel1.text = WeatherManager.shared.dateToTime(weatherPoint.forecastDaily[1].sun.sunset!, format: "HH:mm")
        blockSunsetSunriseLenghtDayLabel1.text = WeatherManager.shared.getDayLenght(
            weatherPoint.forecastDaily[1].sun.sunset?.timeIntervalSince1970,
            weatherPoint.forecastDaily[1].sun.sunrise?.timeIntervalSince1970
        )
    }
}

