//
//  CoreDataWheatherCollectionViewCell.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 23.06.2023.
//

import UIKit

class WheatherCollectionViewCell: UICollectionViewCell {

    private lazy var stackView = CVStackView(axis: .vertical, spacing: 5, alignment: .center)

    private lazy var timeLabel = CVLabel(text: "12:00", size: 14, weight: .regular, numberOfLines: 1, tag: 1)
    private lazy var imageView = CVImage(imageName: "sun24h")
    private lazy var degreeLabel = CVLabel(text: "23", size: 16, weight: .regular, tag: 2)

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = Colors.borderBlue.color.cgColor
        contentView.layer.cornerRadius = 22
        contentView.clipsToBounds = true

        setViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.backgroundColor = .white

        let label = viewWithTag(1) as? UILabel
        label?.textColor = UIColor.black

        let label1 = viewWithTag(2) as? UILabel
        label1?.textColor = UIColor.black
    }

    func setup(_ location: Locations, _ index: Int) {

        var forecast = location.forecast?.allObjects as! [WheatherForecast]
        forecast.sort{ $0.date! < $1.date! }
        var currentDay = forecast[0].forecastHours?.allObjects as! [ForecastHours]
        currentDay.sort { $0.hour < $1.hour }
        var nextDay = forecast[1].forecastHours?.allObjects as! [ForecastHours]
        nextDay.sort { $0.hour < $1.hour }

        let currentHour = getCurrentHour()

        if index >= currentHour {
            timeLabel.text = "\(currentDay[index].hour):00"
            imageView.image = UIImage(named: "\(currentDay[index].condition ?? "")")
            degreeLabel.text = "\(currentDay[index].temp.SСomputed())°"
        } else {
            timeLabel.text = "\(nextDay[index].hour):00"
            imageView.image = UIImage(named: "\(nextDay[index].condition ?? "")")
            degreeLabel.text = "\(nextDay[index].temp.SСomputed())°"
        }

    }

    func getCurrentHour() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let dateInFormat = dateFormatter.string(from: NSDate() as Date)
        return Int(dateInFormat)!
    }

    func setViews(){
        addSubview(stackView)
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(degreeLabel)
    }

    func setConstraints(){
        NSLayoutConstraint.activate([

            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),

            timeLabel.heightAnchor.constraint(equalToConstant: 18),
            imageView.heightAnchor.constraint(equalToConstant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 15)

        ])
    }
}
