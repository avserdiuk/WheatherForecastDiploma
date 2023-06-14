//
//  SettingViewController.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 20.03.2023.
//

import UIKit

class SettingViewController: UIViewController {

    override func loadView() {
        self.view = SettingView()
        view().button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    func view() -> SettingView {
        return self.view as! SettingView
    }
    
    @objc func didTap(){
        navigationController?.popViewController(animated: true)
    }
}

