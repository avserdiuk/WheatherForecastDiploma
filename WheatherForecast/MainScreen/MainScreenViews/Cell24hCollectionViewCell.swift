//
//  Cell24hCollectionViewCell.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 29.04.2024.
//

import Foundation
import UIKit

class Cell24hCollectionViewCell: UICollectionViewCell {
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var hour: UILabel = {
        let label = UILabel()
        label.text = "17"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private lazy var image : UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "sun")
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    private lazy var temperature : UILabel = {
        let label = UILabel()
        label.text = "+30°"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = UIColor(named: "backgroundSecondary")
        layer.borderColor = .none
        layer.borderWidth = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(named: "backgroundSecondary")
        layer.cornerRadius = 15
        
        addSubview(stack)
        stack.addArrangedSubview(hour)
        stack.addArrangedSubview(image)
        stack.addArrangedSubview(temperature)
        
        NSLayoutConstraint.activate([

            stack.topAnchor.constraint(equalTo: super.topAnchor, constant: 5),
            stack.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 0),
            stack.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: 0),
            stack.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: -5),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWith(_ weatherPoint: WeatherPoint, index: Int) {
        hour.text = WeatherManager.shared.dateToTime(weatherPoint.forecastHourly.forecast[index].date, format: "HH")
        temperature.text =  WeatherManager.shared.temperature(Int(weatherPoint.forecastHourly.forecast[index].temperature.value.rounded()))
    }
}
