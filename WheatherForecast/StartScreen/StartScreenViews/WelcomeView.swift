//
//  Welcome.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 28.04.2024.
//

import Foundation
import UIKit

class WelcomeView: UIView {
    
    private lazy var title : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Здравствуйте!"
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        return label
    }()
    
    private lazy var descript : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Для начала работы с погодой добавьте ваш город с помощью строки поиска сверху."
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(title)
        addSubview(descript)
        
        NSLayoutConstraint.activate([
            
            title.topAnchor.constraint(equalTo: super.topAnchor, constant: 0),
            title.centerXAnchor.constraint(equalTo: super.centerXAnchor),
            
            descript.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            descript.centerXAnchor.constraint(equalTo: super.centerXAnchor),
            descript.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: 0),
            descript.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 0),
            descript.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: 0),
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
