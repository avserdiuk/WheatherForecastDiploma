//
//  FooterForTableView.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 28.04.2024.
//

import Foundation
import UIKit

class AppleWeatherTrademarkView: UIView {
    
    private lazy var appleWeatherKitLable : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Weather"
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var appleWeatherKitLink : UITextView = {
        let linkTextView = UITextView()
        linkTextView.translatesAutoresizingMaskIntoConstraints = false
        linkTextView.isUserInteractionEnabled = true
        linkTextView.isSelectable = true
        linkTextView.dataDetectorTypes = .link
        linkTextView.text = "https://weatherkit.apple.com/legal-attribution.html"
        linkTextView.isEditable = false
        linkTextView.backgroundColor = .clear
        linkTextView.textAlignment = .center
        linkTextView.textColor = .white
        linkTextView.tintColor = .systemBlue
        linkTextView.font = UIFont.systemFont(ofSize: 10)
        return linkTextView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(appleWeatherKitLable)
        self.addSubview(appleWeatherKitLink)
        
        NSLayoutConstraint.activate([
        
            appleWeatherKitLable.widthAnchor.constraint(equalToConstant: 350),
            appleWeatherKitLable.centerXAnchor.constraint(equalTo: super.centerXAnchor),
            appleWeatherKitLable.topAnchor.constraint(equalTo: super.topAnchor, constant: 5),
            
            appleWeatherKitLink.widthAnchor.constraint(equalToConstant: 350),
            appleWeatherKitLink.heightAnchor.constraint(equalToConstant: 40),
            appleWeatherKitLink.centerXAnchor.constraint(equalTo: super.centerXAnchor),
            appleWeatherKitLink.topAnchor.constraint(equalTo: appleWeatherKitLable.bottomAnchor, constant: -5),
            appleWeatherKitLink.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: 0),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
