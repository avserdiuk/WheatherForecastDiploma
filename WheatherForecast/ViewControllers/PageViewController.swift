//
//  PageViewController.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 21.03.2023.
//

import UIKit
import CoreLocation

class PageViewController: UIViewController {

    var locations : [String] = UserDefaults.standard.object(forKey: "Locations") as? [String] ?? []
    var wheathers : [Wheather] = []

    lazy var controllers : [UIViewController] = {
        var controllers : [UIViewController] = []
        self.wheathers.enumerated().forEach {
            self.controllers.append(WheatherViewController(wheather: $1, viewController: self, titleLabel: self.locations[$0]))
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

        let myGroup = DispatchGroup()

        wheathers = []
        locations.forEach {
            myGroup.enter()
            NetworkManager().getCoordsWithString($0) { desc, coords in
                NetworkManager().getWheater(coordinates: coords) { wheather in
                    DispatchQueue.main.async {
                        self.wheathers.append(wheather)
                        print(wheather.fact.temp)
                        myGroup.leave()
                    }
                }
            }
        }

        myGroup.notify(queue: .main) {
            self.view().pageControl.isHidden = false
            self.view().activityIndicator.stopAnimating()

            self.controllers = []
            self.wheathers.enumerated().forEach {
                self.controllers.append(WheatherViewController(wheather: $1, viewController: self, titleLabel: self.locations[$0]))
            }

            self.view().pageViewController.setViewControllers([self.controllers[self.controllers.count-1]], direction: .forward, animated: true)

            self.title = self.locations[self.controllers.count-1]

            self.view().pageControl.numberOfPages = self.locations.count
            self.view().pageControl.currentPage = self.locations.count
            
        }
    }

    func setNavigationBar(){

        let menu = UIBarButtonItem(image: UIImage(named: "menu"), style: .done, target: self, action: #selector(showMenu))
        let point = UIBarButtonItem(image: UIImage(named: "point"), style: .done, target: self, action: #selector(showAlert))
        navigationItem.leftBarButtonItems = [menu]
        navigationItem.rightBarButtonItems = [point]
        navigationController?.navigationBar.tintColor = .black

    }

    @objc func showMenu(){
        let controller = SettingViewController()
        navigationController?.pushViewController(controller, animated: true)
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
                self.locations.append(desc)
                UserDefaults.standard.set(self.locations, forKey: "Locations")

                DispatchQueue.main.async {
                    self.view().informationLabel.isHidden = true
                    self.view().wrapperView.isHidden = true
                    self.viewDidLoad()
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
            self.title = locations[index]
            self.view().pageControl.currentPage = index

        }
    }
}
