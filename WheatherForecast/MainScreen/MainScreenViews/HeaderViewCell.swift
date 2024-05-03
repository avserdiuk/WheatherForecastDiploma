//
//  Section0View.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 29.04.2024.
//

import Foundation
import UIKit

class HeaderViewCell: UITableViewCell {
    
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
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
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
        label.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(image)
        addSubview(locationLabel)
        addSubview(temperatureLabel)
        addSubview(conditionLabel)
        
        
        NSLayoutConstraint.activate([
            
            image.topAnchor.constraint(equalTo: super.topAnchor, constant: 10),
            image.centerXAnchor.constraint(equalTo: super.centerXAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 21),
            locationLabel.centerXAnchor.constraint(equalTo: super.centerXAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 0),
            temperatureLabel.centerXAnchor.constraint(equalTo: super.centerXAnchor),
            
            conditionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 0),
            conditionLabel.centerXAnchor.constraint(equalTo: super.centerXAnchor),
            conditionLabel.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: -10)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWith(_ weatherPoint: WeatherPoint){
        locationLabel.text = weatherPoint.location.city
        temperatureLabel.text = WeatherManager.shared.temperature(Int(weatherPoint.current.temperature.value.rounded()))
        conditionLabel.text = WeatherManager.shared.getCondition(weatherPoint.current.condition)
    }
}
