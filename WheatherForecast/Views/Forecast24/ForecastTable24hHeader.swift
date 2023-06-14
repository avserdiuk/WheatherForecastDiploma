//
//  CustomTable24hHeader.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 23.03.2023.
//

import UIKit

class ForecastTable24hHeader: UITableViewHeaderFooterView {

    private lazy var image = CVImage(imageName: "graph")

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        addSubview(image)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setConstraints(){
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
        ])
    }
}
