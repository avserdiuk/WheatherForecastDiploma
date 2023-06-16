//
//  SettingViewController.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 20.03.2023.
//

import UIKit

class SettingViewController: UIViewController {

    var settings = UserDefaults.standard.array(forKey: "settings") ?? [] // берем актуальные настроки
    var switchers: [CVSwithcer] = [] // массив для работы с переключатели


    override func loadView() {
        self.view = SettingView()
    }

    override func viewDidLoad() {
        view().button.addTarget(self, action: #selector(didTap), for: .touchUpInside)

        switchers = [view().settingItem0Switcher, view().settingItem1Switcher, view().settingItem2Switcher, view().settingItem3Switcher]
        setupSwitchers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    func view() -> SettingView {
        return self.view as! SettingView
    }

    // делаем корректную установку значений свитчеров исходя из настроек пользователя
    func setupSwitchers(){
        settings.enumerated().forEach {
            switchers[$0].isSelected = $1 as? Bool ?? false
        }
    }

    // далем сохранение настроек пользователя и запись в юзер дефолтс
    func saveSettings(){
        switchers.enumerated().forEach {
            settings[$0] = $1.isSelected
        }

        UserDefaults.standard.set(settings, forKey: "settings")
    }
    
    @objc func didTap(){
        saveSettings()
        navigationController?.popViewController(animated: true)
    }
}

