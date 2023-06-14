//
//  CustomDailyWheatherDayNightTableViewCell.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 25.03.2023.
//

import UIKit

class DailyWheatherDayNightTableViewCell: UITableViewCell {

    private lazy var wrapperView = CVView()
    private lazy var titleLabel = CVLabel(text: dailyWheatherSunMoonTitleLabel, size: 18, weight: .regular)

    private lazy var leftView = CVView()
    private lazy var rightView = CVView()
    private lazy var vr = CVView(backgroundColor: .accentBlue)

    private lazy var leftStackView1 = CVStackView(axis: .vertical, spacing: 17)
    private lazy var leftImageView = CVImage(imageName: "sunSM")
    private lazy var leftItem01Label = CVLabel(text: dailyWheatherSunMoonLeftItem01Label, size: 14, weight: .regular, color: .textGray)
    private lazy var leftItem02Label = CVLabel(text: dailyWheatherSunMoonLeftItem02Label, size: 14, weight: .regular, color: .textGray)

    private lazy var leftStackView2 = CVStackView(axis: .vertical, spacing: 17, alignment: .trailing)
    private lazy var leftItem10Label = CVLabel(text: "14 ч 26 м", size: 16, weight: .regular)
    private lazy var leftItem11Label = CVLabel(text: "05:19", size: 16, weight: .regular)
    private lazy var leftItem12Label = CVLabel(text: "19:46", size: 16, weight: .regular)


    private lazy var rightStackView1 = CVStackView(axis: .vertical, spacing: 17)
    private lazy var rightImageView = CVImage(imageName: "moonSM")
    private lazy var rightItem01Label = CVLabel(text: dailyWheatherSunMoonLeftItem01Label, size: 14, weight: .regular, color: .textGray)
    private lazy var rightItem02Label = CVLabel(text: dailyWheatherSunMoonLeftItem02Label, size: 14, weight: .regular, color: .textGray)

    private lazy var rightStackView2 = CVStackView(axis: .vertical, spacing: 17, alignment: .trailing)
    private lazy var rightItem10Label = CVLabel(text: "14 ч 26 м", size: 16, weight: .regular)
    private lazy var rightItem11Label = CVLabel(text: "05:19", size: 16, weight: .regular)
    private lazy var rightItem12Label = CVLabel(text: "19:46", size: 16, weight: .regular)


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(_ wheather: Forecast){
        leftItem11Label.text = wheather.sunrise
        leftItem12Label.text = wheather.sunset

        rightItem11Label.text = wheather.sunset
        rightItem12Label.text = wheather.sunrise
    }

    func setViews(){
        addSubview(wrapperView)
        wrapperView.addSubview(titleLabel)
        wrapperView.addSubview(leftView)
        leftView.addSubview(leftStackView1)
        leftView.addSubview(leftImageView)
        leftStackView1.addArrangedSubview(leftItem01Label)
        leftStackView1.addArrangedSubview(leftItem02Label)
        leftView.addSubview(leftStackView2)
        leftStackView2.addArrangedSubview(leftItem10Label)
        leftStackView2.addArrangedSubview(leftItem11Label)
        leftStackView2.addArrangedSubview(leftItem12Label)
        rightView.addSubview(rightStackView1)
        rightView.addSubview(rightImageView)
        rightStackView1.addArrangedSubview(rightItem01Label)
        rightStackView1.addArrangedSubview(rightItem02Label)
        rightView.addSubview(rightStackView2)
        rightStackView2.addArrangedSubview(rightItem10Label)
        rightStackView2.addArrangedSubview(rightItem11Label)
        rightStackView2.addArrangedSubview(rightItem12Label)
        wrapperView.addSubview(vr)
        wrapperView.addSubview(rightView)
    }

    func setConstraints(){
        NSLayoutConstraint.activate([
            wrapperView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            wrapperView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            wrapperView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            wrapperView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 0),

            titleLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: 15),
            titleLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -130),

            leftView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 17),
            leftView.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: 0),
            leftView.widthAnchor.constraint(equalToConstant: 160),
            leftView.heightAnchor.constraint(equalToConstant: 97),

            leftImageView.topAnchor.constraint(equalTo: leftView.topAnchor, constant: 5),
            leftImageView.leftAnchor.constraint(equalTo: leftView.leftAnchor, constant: 28),

            leftStackView1.topAnchor.constraint(equalTo: leftImageView.bottomAnchor, constant: 15),
            leftStackView1.leftAnchor.constraint(equalTo: leftView.leftAnchor, constant: 28),

            leftStackView2.topAnchor.constraint(equalTo: leftView.topAnchor, constant: 5),
            leftStackView2.rightAnchor.constraint(equalTo: leftView.rightAnchor, constant: 0),

            rightImageView.topAnchor.constraint(equalTo: rightView.topAnchor, constant: 5),
            rightImageView.leftAnchor.constraint(equalTo: rightView.leftAnchor, constant: 0),

            rightStackView1.topAnchor.constraint(equalTo: rightImageView.bottomAnchor, constant: 17),
            rightStackView1.leftAnchor.constraint(equalTo: rightView.leftAnchor, constant: 0),

            rightStackView2.topAnchor.constraint(equalTo: rightView.topAnchor, constant: 5),
            rightStackView2.rightAnchor.constraint(equalTo: rightView.rightAnchor, constant: -28),

            vr.widthAnchor.constraint(equalToConstant: 1),
            vr.heightAnchor.constraint(equalToConstant: 97),
            vr.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            vr.centerYAnchor.constraint(equalTo: leftView.centerYAnchor),

            rightView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 17),
            rightView.rightAnchor.constraint(equalTo: wrapperView.rightAnchor, constant: 0),
            rightView.widthAnchor.constraint(equalToConstant: 160),
            rightView.heightAnchor.constraint(equalToConstant: 97),
        ])
    }
}
