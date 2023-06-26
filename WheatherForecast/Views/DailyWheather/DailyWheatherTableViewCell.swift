//
//  CustomDailyWheatherTableViewCel.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 24.03.2023.
//

import UIKit

class DailyWheatherTableViewCell: UITableViewCell {

    var location: Locations?

    private lazy var wrapperView = CVView(backgroundColor: .backgroundWhite, cornerRadius: 5)
    private lazy var titleLabel = CVLabel(text: dailyWheatherTitleLabel, size: 18, weight: .regular)
    private lazy var topStackView = CVStackView(axis: .horizontal, spacing: 10)
    private lazy var wheatherImageView = CVImage(imageName: "rain24h")
    private lazy var dergeeLable = CVLabel(text: "13°", size: 30, weight: .regular)
    private lazy var wheatherLable = CVLabel(text: "Ливни", size: 18, weight: .semibold)

    private lazy var icoStackView = CVStackView(axis: .vertical, spacing: 16)
    private lazy var row1IcoImageView = CVImage(imageName: "dailyIcoTemp")
    private lazy var row2IcoImageView = CVImage(imageName: "dailyIcoWind")
    private lazy var row3IcoImageView = CVImage(imageName: "dailyIcoSun")
    private lazy var row4IcoImageView = CVImage(imageName: "dailyIcoRain")
    private lazy var row5IcoImageView = CVImage(imageName: "dailyIcoCloud")

    private lazy var label1StackView = CVStackView(axis: .vertical, spacing: 22.5)
    private lazy var row01Label = CVLabel(text: dailyWheatherRow01Label, size: 14, weight: .regular)
    private lazy var row02Label = CVLabel(text: dailyWheatherRow02Label, size: 14, weight: .regular)
    private lazy var row03Label = CVLabel(text: dailyWheatherRow03Label, size: 14, weight: .regular)
    private lazy var row04Label = CVLabel(text: dailyWheatherRow04Label, size: 14, weight: .regular)
    private lazy var row05Label = CVLabel(text: dailyWheatherRow05Label, size: 14, weight: .regular)

    private lazy var label2StackView = CVStackView(axis: .vertical, spacing: 17.5, alignment: .trailing)
    private lazy var row11Label = CVLabel(text: "11°", size: 18, weight: .regular)
    private lazy var row12Label = CVLabel(text: "5 м/с ЮГЗ", size: 18, weight: .regular)
    private lazy var row13Label = CVLabel(text: "4 (умерен)", size: 18, weight: .regular)
    private lazy var row14Label = CVLabel(text: "55%", size: 18, weight: .regular)
    private lazy var row15Label = CVLabel(text: "72%", size: 18, weight: .regular)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(_ timeOfDay: String, _ location : ForecastPart, _ indexPath: IndexPath){

        titleLabel.text = timeOfDay
        dergeeLable.text = "\(location.tempAvg.SСomputed())°"
        wheatherLable.text = "\(getCondition(location.condition!))"
        row11Label.text = "\(location.tempFeelLike.SСomputed())°"
        row12Label.text = "\(location.windSpeed) м/с \(getWindDir(location.windDir!))"
        row13Label.text = "\(getUvIndex(Int(location.uvIndex)))"
        row14Label.text = "\(Int(location.precipitation)*100)%"
        row15Label.text = "\(Int(location.cloudness)*100)%"
    }

    func setViews(){
        addSubview(wrapperView)
        wrapperView.addSubview(titleLabel)
        wrapperView.addSubview(topStackView)
        topStackView.addArrangedSubview(wheatherImageView)
        topStackView.addArrangedSubview(dergeeLable)
        wrapperView.addSubview(wheatherLable)
        wrapperView.addSubview(icoStackView)
        icoStackView.addArrangedSubview(row1IcoImageView)
        icoStackView.addArrangedSubview(row2IcoImageView)
        icoStackView.addArrangedSubview(row3IcoImageView)
        icoStackView.addArrangedSubview(row4IcoImageView)
        icoStackView.addArrangedSubview(row5IcoImageView)
        wrapperView.addSubview(label1StackView)
        label1StackView.addArrangedSubview(row01Label)
        label1StackView.addArrangedSubview(row02Label)
        label1StackView.addArrangedSubview(row03Label)
        label1StackView.addArrangedSubview(row04Label)
        label1StackView.addArrangedSubview(row05Label)
        wrapperView.addSubview(label2StackView)
        label2StackView.addArrangedSubview(row11Label)
        label2StackView.addArrangedSubview(row12Label)
        label2StackView.addArrangedSubview(row13Label)
        label2StackView.addArrangedSubview(row14Label)
        label2StackView.addArrangedSubview(row15Label)
    }

    func setConstraints(){
        NSLayoutConstraint.activate([
            wrapperView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            wrapperView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            wrapperView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            wrapperView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 0),

            titleLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 25),
            titleLabel.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: 15),

            wheatherImageView.widthAnchor.constraint(equalToConstant: 26),

            topStackView.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            topStackView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),

            wheatherLable.centerXAnchor.constraint(equalTo: topStackView.centerXAnchor),
            wheatherLable.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10),

            icoStackView.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: 15),
            icoStackView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 109),

            label1StackView.leftAnchor.constraint(equalTo: icoStackView.rightAnchor, constant: 15),
            label1StackView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 112),

            label2StackView.rightAnchor.constraint(equalTo: wrapperView.rightAnchor, constant: -15),
            label2StackView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 112),
            label2StackView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -20)

        ])
    }
}
