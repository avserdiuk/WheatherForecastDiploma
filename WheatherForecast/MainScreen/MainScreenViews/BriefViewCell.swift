//
//  Section1ViewCell.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 29.04.2024.
//

import Foundation
import UIKit

class BriefViewCell: UITableViewCell {
    
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
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1))
        return label
    }()
    
    private lazy var feelLikeLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+34°"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
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
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1))
        return label
    }()
    
    private lazy var windSpeedLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5 м/с"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
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
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1))
        return label
    }()
    
    private lazy var humidityLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "58%"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
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
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1))
        return label
    }()
    
    private lazy var uvLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor(cgColor: CGColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1))
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(blockInformation)
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
        
        NSLayoutConstraint.activate([
            blockInformation.topAnchor.constraint(equalTo: super.topAnchor, constant: 10),
            blockInformation.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 0),
            blockInformation.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: 0),
            blockInformation.heightAnchor.constraint(equalToConstant: 49),
            blockInformation.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: 0),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWith(_ weatherPoint: WeatherPoint){
        feelLikeLabel1.text = WeatherManager.shared.temperature(Int(weatherPoint.current.apparentTemperature.value.rounded()))
        windSpeedLabel1.text = "\(Int(weatherPoint.current.wind.speed.converted(to: .metersPerSecond).value.rounded())) м/с"
        humidityLabel1.text = "\(Int(weatherPoint.current.humidity.magnitude * 100))%"
        uvLabel1.text = "\(weatherPoint.current.uvIndex.value)"
    }
}
