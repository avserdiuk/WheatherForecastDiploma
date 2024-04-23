//
//  CustomDailyWheatherAirQualityTableViewCell.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 25.03.2023.
//

import UIKit

class DailyWheatherAirQualityTableViewCell: UITableViewCell {

    private lazy var wrapperView = CVView(backgroundColor: .transparent, cornerRadius: 5)
    private lazy var titleLabel = CVLabel(text: dailyWheatherAirQualityTitleLabel, size: 18, weight: .regular)
    private lazy var indexLabel = CVLabel(text: "42", size: 30, weight: .regular)
    private lazy var qualityView = CVView(backgroundColor: .backgroundGreen, cornerRadius: 5)
    private lazy var qualityLabel = CVLabel(text: dailyWheatherAirQualityQualityLabel, size: 18, weight: .regular, color: .textWhite)
    private lazy var descripntionLabel = CVLabel(text: dailyWheatherAirQualityDescripntionLabel, size: 15, weight: .regular, color: .textGray, numberOfLines: 0)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setViews()
        setConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setViews() {
        addSubview(wrapperView)
        wrapperView.addSubview(titleLabel)
        wrapperView.addSubview(indexLabel)
        wrapperView.addSubview(qualityView)
        qualityView.addSubview(qualityLabel)
        wrapperView.addSubview(descripntionLabel)
    }

    func setConstraints(){
        NSLayoutConstraint.activate([
            wrapperView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            wrapperView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            wrapperView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            wrapperView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 0),
            
            titleLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: 15),

            indexLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            indexLabel.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: 15),

            qualityView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            qualityView.leftAnchor.constraint(equalTo: indexLabel.rightAnchor, constant: 15),

            qualityLabel.topAnchor.constraint(equalTo: qualityView.topAnchor, constant: 3),
            qualityLabel.leftAnchor.constraint(equalTo: qualityView.leftAnchor, constant: 18),
            qualityLabel.rightAnchor.constraint(equalTo: qualityView.rightAnchor, constant: -18),
            qualityLabel.bottomAnchor.constraint(equalTo: qualityView.bottomAnchor, constant: -3),

            descripntionLabel.topAnchor.constraint(equalTo: qualityView.bottomAnchor, constant: 15),
            descripntionLabel.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: 15),
            descripntionLabel.rightAnchor.constraint(equalTo: wrapperView.rightAnchor, constant: -15),
            descripntionLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -15)

        ])
    }
}
