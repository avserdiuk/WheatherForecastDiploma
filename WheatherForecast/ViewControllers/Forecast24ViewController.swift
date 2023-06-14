//
//  Forecast24ViewController.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 23.03.2023.
//

import UIKit

class Forecast24ViewController: UIViewController {

    weak var viewController : UIViewController?
    var wheather : Wheather?
    var indexMassive : [Int] = []

    override func loadView() {
        self.view = Forecast24View()

        view().backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        view().tableView.dataSource = self
        view().tableView.delegate = self

        indexMassive = getIndixesMass()
    }

    func view() -> Forecast24View {
        return self.view as! Forecast24View
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    @objc func didTapBackButton(){
        navigationController?.isNavigationBarHidden = false
        viewController?.navigationController?.popViewController(animated: true)
    }

    func getIndixesMass() -> [Int] {
        var hour = getCurrentHourAt3h()
        var hours : [Int] = []
        var index = 0

        for _ in 0...7 {
            if hour < 24 {
                hours.append(hour)
                hour += 3
            } else {
                hours.append(index)
                index += 3
            }
        }
        return hours
    }
}

extension Forecast24ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let wheather else { return 0 }
        return wheather.forecasts[0].hours.count/3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTable24hViewCell()
        if let wheather = wheather {
            cell.setup(wheather, indexPath, indexMassive)
        }
        return cell
    }
}

extension Forecast24ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = CustomTable24hHeader()
        return cell
    }
}
