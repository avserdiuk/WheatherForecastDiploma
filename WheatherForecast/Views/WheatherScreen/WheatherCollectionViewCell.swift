//
//  CustomCollectionViewCell.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 21.03.2023.
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

    func setup(_ wheater: Wheather, _ index: Int) {

        let currentHour = getCurrentHour()
        
        if index >= currentHour {
            timeLabel.text = "\(wheater.forecasts[0].hours[index].hour):00"
            imageView.image = UIImage(named: "\(wheater.forecasts[0].hours[index].condition)")
            degreeLabel.text = "\(wheater.forecasts[0].hours[index].temp)°"
        } else {
            timeLabel.text = "\(wheater.forecasts[1].hours[index].hour):00"
            imageView.image = UIImage(named: "\(wheater.forecasts[1].hours[index].condition)")
            degreeLabel.text = "\(wheater.forecasts[1].hours[index].temp)°"
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
