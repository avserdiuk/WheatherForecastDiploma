//
//  CoreDataWheatherViewController.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 05.04.2023.
//

import UIKit

class WheatherViewController: UIViewController {

    weak var viewController : UIViewController?
    var location : Locations?
    var titleLabel: String?

    private lazy var tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .white
        table.showsVerticalScrollIndicator = false
        table.separatorColor = .clear
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(tableView)
        setConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    init(location: Locations, viewController : UIViewController) {
        super.init(nibName: nil, bundle: nil)
        self.location = location
        self.viewController = viewController
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }

}

extension WheatherViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 1 else { return 0 }
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WheatherTableViewCell()
        if let location = location {
            cell.setup(location, indexPath)
        }
        cell.selectionStyle = .none
        return cell
    }
}

extension WheatherViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 1 else {
            let cell = WheatherTableHeader()
            cell.viewController = self.viewController
            if let location = location {
                cell.location = location
                cell.titleLabel = titleLabel
                cell.setup(location)
            } else {
                print("error")
            }
            return cell
        }
        return WheatherSectionHeader()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DailyWheatherViewController()
        controller.location = location
        controller.index = indexPath.row
        controller.view().titleLabel.text = titleLabel
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
