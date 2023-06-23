//
//  CustomDailyWheatherCollectionViewCell.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 24.03.2023.
//

import UIKit

class DailyWheatherCollectionViewCell: UICollectionViewCell {

    private lazy var view = CVView(backgroundColor: .accentBlue)
    private lazy var titleLabel = CVLabel(text: "16/04 ПТ", size: 18, weight: .regular, color: .textBlack, tag: 1)

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.tag = 0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(_ location: Locations, _ indexPath: IndexPath){

        var forecast = location.forecast?.allObjects as! [WheatherForecast]
        forecast.sort {$0.date! < $1.date!}
        let date = forecast[indexPath.row].unixtime
        titleLabel.text = getTime(unixtime: Int(date))
    }

    func getTime(unixtime : Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(unixtime))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM E"
        let dateInFormat = dateFormatter.string(from: date as Date)
        return dateInFormat
    }

}
