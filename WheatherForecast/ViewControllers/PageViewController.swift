//
//  PageViewController.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 21.03.2023.
//

import UIKit
import CoreLocation

class PageViewController: UIViewController {

    var locations = CoreDataManager.shared.locations

    lazy var controllers : [UIViewController] = {
        var controllers : [UIViewController] = []
        self.locations.enumerated().forEach {
            self.controllers.append(WheatherViewController(location: $1, viewController: self))
        }
        return controllers
    }()

    override func loadView() {
        self.view = PageView()
        view().pageViewController.dataSource = self
        view().pageViewController.delegate = self

        view().pageControl.numberOfPages = self.locations.count

    }

    override func viewDidLoad() {
        setNavigationBar()

        if locations.isEmpty {
            view().activityIndicator.stopAnimating()
            view().informationLabel.isHidden = false
        } else {
            showWheather()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    func view() -> PageView {
        return self.view as! PageView
    }

    func showWheather(){
        view().activityIndicator.startAnimating()

        self.view().pageControl.isHidden = false
        self.view().activityIndicator.stopAnimating()

        self.controllers = []
        self.locations.enumerated().forEach {
            self.controllers.append(WheatherViewController(location: $1, viewController: self))
        }

        self.view().pageViewController.setViewControllers([self.controllers[self.controllers.count-1]], direction: .forward, animated: true)

        self.title = self.locations[self.controllers.count-1].name

        self.view().pageControl.numberOfPages = self.locations.count
        self.view().pageControl.currentPage = self.locations.count

    }

    func setNavigationBar(){

        let menu = UIBarButtonItem(image: UIImage(named: "menu"), style: .done, target: self, action: #selector(showMenu))
        let point = UIBarButtonItem(image: UIImage(named: "point"), style: .done, target: self, action: #selector(showAlert))
        let trash = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(showDeleteAlert))
        navigationItem.leftBarButtonItems = [menu]
        navigationItem.rightBarButtonItems = [point]

        // добавляем ограничения на ввод и удаление локаций
        if CoreDataManager.shared.locations.count > 4  {
            navigationItem.rightBarButtonItems = [trash]
        } else if CoreDataManager.shared.locations.count == 1 {
            navigationItem.rightBarButtonItems = [point]
        } else {
            navigationItem.rightBarButtonItems = [point, trash]
        }

        navigationController?.navigationBar.tintColor = .black

    }

    @objc func showMenu(){
        let controller = SettingViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

    @objc func showDeleteAlert(){
        view().wrapperView.isHidden = false
        let city = CoreDataManager.shared.locations[view().pageControl.currentPage].name!

        let alert = UIAlertController(title: "Удалить \(city) из прогноза погоды?", message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { [self] _ in

            CoreDataManager.shared.deleteLocation(location: CoreDataManager.shared.locations[view().pageControl.currentPage]) {
                DispatchQueue.main.async {
                    self.locations = CoreDataManager.shared.locations
                    self.viewDidLoad()
                    self.view().wrapperView.isHidden = true
                    print("done")
                }
            }

        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { _ in
            self.view().wrapperView.isHidden = true
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func showAlert(){
        view().wrapperView.isHidden = false

        let alert = UIAlertController(title: "Добавить новый город", message: "например \"Омск\"", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = ""
            textField.placeholder = "Введите ваш город:"
        }

        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            guard let city = textField?.text else { return }

            NetworkManager().getCoordsWithString(city) { desc, coords in
                NetworkManager().getWheater(coordinates: coords) { wheather in
                    CoreDataManager.shared.addLocation(name: desc, longitude: Float(coords.1), latitude: Float(coords.0), wheather: wheather) {

                        DispatchQueue.main.async {
                            self.locations = CoreDataManager.shared.locations
                            self.viewDidLoad()
                            self.view().wrapperView.isHidden = true
                        }
                    }
                }
            }

        }))

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { _ in
            self.view().wrapperView.isHidden = true
        }))

        self.present(alert, animated: true, completion: nil)
    }

}

extension PageViewController : UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let viewController = viewController as? WheatherViewController else {return nil}
        if let index = controllers.firstIndex(of: viewController) {
            if index > 0 {
                return controllers[index-1]
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let viewController = viewController as? WheatherViewController else {return nil}
        if let index = controllers.firstIndex(of: viewController) {
            if index < controllers.count - 1 {
                return controllers[index+1]
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let index = controllers.firstIndex(of: pendingViewControllers[0]){
            self.title = locations[index].name
            self.view().pageControl.currentPage = index

        }
    }
}
