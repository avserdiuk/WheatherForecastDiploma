//
//  CustomTableViewCell.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 21.03.2023.
//

import UIKit

class WheatherTableViewCell: UITableViewCell {

    private lazy var wrapper = CVView(backgroundColor: .backgroundWhite, cornerRadius: 5)
    private lazy var dateLabel = CVLabel(text: "23/04", size: 16, weight: .regular, color: .textGray)
    private lazy var rainImage = CVImage(imageName: "rain24h")
    private lazy var rainLabel = CVLabel(text: "75%", size: 12, weight: .regular, color: .accentBlue)
    private lazy var titleLabel = CVLabel(text: "Местами дождь", size: 16, weight: .regular, color: .textBlack, textAlignment: .center)
    private lazy var degreeLabel = CVLabel(text: "4°-11°", size: 18, weight: .regular, color: .textBlack, textAlignment: .right)
    private lazy var arrorImage = CVImage(imageName: "rightArrow")

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setViews()
        setConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        rainImage.image = nil
        rainLabel.text = nil
        titleLabel.text = nil
        degreeLabel.text = nil
    }

    func setup(_ wheather: Wheather, _ indexPath : IndexPath){
        dateLabel.text = getTime(unixtime: wheather.forecasts[indexPath.row].unixtime)
        titleLabel.text = getCondition(wheather.forecasts[indexPath.row].parts.day.condition)
        degreeLabel.text = "\(wheather.forecasts[indexPath.row].parts.night.tempMin)°/\(wheather.forecasts[indexPath.row].parts.day.tempMax)°"
        rainLabel.text =  "\(Int(wheather.forecasts[indexPath.row].parts.day.precipitation*100))%"
        rainImage.image = UIImage(named: "\(wheather.forecasts[indexPath.row].parts.day.condition)")
    }

    func getTime(unixtime : Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(unixtime))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM "
        let dateInFormat = dateFormatter.string(from: date as Date)
        return dateInFormat
    }

    func setViews(){
        addSubview(wrapper)
        wrapper.addSubview(dateLabel)
        wrapper.addSubview(rainImage)
        wrapper.addSubview(rainLabel)
        wrapper.addSubview(titleLabel)
        wrapper.addSubview(degreeLabel)
        wrapper.addSubview(arrorImage)

    }

    func setConstraints(){
        NSLayoutConstraint.activate([

            wrapper.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            wrapper.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            wrapper.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            wrapper.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),

            dateLabel.topAnchor.constraint(equalTo: wrapper.topAnchor, constant: 6),
            dateLabel.leftAnchor.constraint(equalTo: wrapper.leftAnchor, constant: 10),
            dateLabel.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor, constant: -31),

            rainImage.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            rainImage.leftAnchor.constraint(equalTo: wrapper.leftAnchor, constant: 10),
            rainImage.heightAnchor.constraint(equalToConstant: 18),
            rainImage.widthAnchor.constraint(equalToConstant: 18),

            rainLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 6),
            rainLabel.leftAnchor.constraint(equalTo: rainImage.rightAnchor, constant: 5),

            titleLabel.centerYAnchor.constraint(equalTo: wrapper.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: wrapper.leftAnchor, constant: 66),
            titleLabel.rightAnchor.constraint(equalTo: wrapper.rightAnchor, constant: -100),

            degreeLabel.centerYAnchor.constraint(equalTo: wrapper.centerYAnchor),
            degreeLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 3),
            degreeLabel.rightAnchor.constraint(equalTo: wrapper.rightAnchor, constant: -26),

            arrorImage.centerYAnchor.constraint(equalTo: wrapper.centerYAnchor),
            arrorImage.leftAnchor.constraint(equalTo: degreeLabel.rightAnchor, constant: 10),
            arrorImage.rightAnchor.constraint(equalTo: wrapper.rightAnchor, constant: -10),

        ])
    }
}
