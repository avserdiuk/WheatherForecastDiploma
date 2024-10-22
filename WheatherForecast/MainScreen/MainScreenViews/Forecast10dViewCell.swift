//
//  Forecast10dViewCell.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 29.04.2024.
//

import Foundation
import UIKit

class Forecast10dViewCell: UITableViewCell {
    
    private lazy var wrapper : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "backgroundSecondary")
        view.layer.cornerRadius = 11
        return view
    }()
    
    private lazy var date: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "29/04 ПН"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var condition : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Солнечно"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private lazy var minMax : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+5°/+19°"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(wrapper)
        wrapper.addSubview(date)
        wrapper.addSubview(condition)
        wrapper.addSubview(minMax)
        
        NSLayoutConstraint.activate([
            
            wrapper.topAnchor.constraint(equalTo: super.topAnchor, constant: 5),
            wrapper.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 0),
            wrapper.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: 0),
            wrapper.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: -5),
        
            date.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: 10),
            date.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor, constant: -20),
            date.centerYAnchor.constraint(equalTo: wrapper.centerYAnchor),
            
            condition.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor),
            condition.centerYAnchor.constraint(equalTo: wrapper.centerYAnchor),
            
            minMax.centerYAnchor.constraint(equalTo: wrapper.centerYAnchor),
            minMax.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWith(_ weatherPoint: WeatherPoint, index: Int){
        date.text = WeatherManager.shared.dateToTime(weatherPoint.forecastDaily.forecast[index].date, format: "dd.MM, E")
        condition.text = WeatherManager.shared.getCondition(weatherPoint.forecastDaily[index].condition).0
        minMax.text = "\(WeatherManager.shared.temperature(Int(weatherPoint.forecastDaily[index].lowTemperature.value.rounded())))/\(WeatherManager.shared.temperature(Int(weatherPoint.forecastDaily[index].highTemperature.value.rounded())))"
        
    }
}
