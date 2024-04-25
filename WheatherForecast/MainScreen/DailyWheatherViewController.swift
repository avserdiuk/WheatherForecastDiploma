//
//  DailyWheatherViewController.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 24.03.2023.
//

import UIKit

class DailyWheatherViewController: UIViewController {

    var location : Locations?
    var index : Int = 0

    override func loadView() {
        self.view = DailyWheatherView()

        view().backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        view().tableView.delegate = self
        view().tableView.dataSource = self
    }

    func view() -> DailyWheatherView {
        return self.view as! DailyWheatherView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    @objc func didTapBackButton(){
        navigationController?.isNavigationBarHidden = false
        navigationController?.popViewController(animated: true)
    }
}

extension DailyWheatherViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let location else { return UITableViewCell() }

        var forecast = location.forecast?.allObjects as! [WheatherForecast]
        forecast.sort {$0.date! < $1.date!}
        var parts = forecast[index].forecastPart?.allObjects as! [ForecastPart]
        parts.sort{ $0.name! < $1.name! }

        if indexPath.row == 0 {
            let cell = DailyWheatherTableViewCell()
            cell.setup("День", parts[0], indexPath)
            return cell
        } else if indexPath.row == 1 {
            let cell = DailyWheatherTableViewCell()
            cell.setup("Ночь", parts[1], indexPath)
            return cell
        } else if indexPath.row == 2 {
            let cell = DailyWheatherDayNightTableViewCell()
            cell.setup(forecast[index])
            return cell
        } else {
            return DailyWheatherAirQualityTableViewCell()
        }
    }
}

extension DailyWheatherViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = DailyWheatherTableHeader()
        header.location = location
        header.index = index
        header.delegate = self
        return header
    }
}
