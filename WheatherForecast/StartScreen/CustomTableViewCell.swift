//
//  CustomTableViewCell.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 25.04.2024.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    private lazy var wrapper: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(cgColor: CGColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1))
        view.layer.cornerRadius = 11
        return view
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Омск"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var temperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+30°"
        label.font = UIFont.systemFont(ofSize: 60, weight: .medium)
        return label
    }()
    
    private lazy var image: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "sun")
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(wrapper)
        wrapper.addSubview(title)
        wrapper.addSubview(temperature)
        wrapper.addSubview(image)
        
        NSLayoutConstraint.activate([
            
            wrapper.topAnchor.constraint(equalTo: super.topAnchor, constant: 0),
            wrapper.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 0),
            wrapper.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: 0),
            wrapper.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: -10),
            
            title.topAnchor.constraint(equalTo: wrapper.topAnchor, constant: 25),
            title.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: 20),
            
            temperature.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 13),
            temperature.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: 20),
            temperature.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor, constant: -20),
            
            image.topAnchor.constraint(equalTo: wrapper.topAnchor, constant: 33),
            image.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -33),
            image.heightAnchor.constraint(equalToConstant: 88),
            image.widthAnchor.constraint(equalToConstant: 88),
            
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(location: Location){
        title.text = location.city
    }
}
