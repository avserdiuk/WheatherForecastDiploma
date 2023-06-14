//
//  DailyWheatherViewController.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 24.03.2023.
//

import UIKit

class DailyWheatherViewController: UIViewController {

    var wheather : Wheather?
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
        guard let wheather else { return UITableViewCell() }
        
        if indexPath.row == 0 {
            let cell = CustomDailyWheatherTableViewCell()
            cell.setup("День", wheather.forecasts[index].parts.day, indexPath)
            return cell
        } else if indexPath.row == 1 {
            let cell = CustomDailyWheatherTableViewCell()
            cell.setup("Ночь", wheather.forecasts[index].parts.night, indexPath)
            return cell
        } else if indexPath.row == 2 {
            let cell = CustomDailyWheatherDayNightTableViewCell()
            cell.setup(wheather.forecasts[index])
            return cell
        } else {
            return CustomDailyWheatherAirQualityTableViewCell()
        }
    }
}

extension DailyWheatherViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = CustomDailyWheatherTableHeader()
        header.wheather = wheather
        header.index = index
        header.delegate = self
        return header
    }
}
