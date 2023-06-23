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
        view().settingItem3Switcher.addTarget(self, action: #selector(notificationRequest), for: .touchUpInside)

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

    // при включении уведомлений отправляем запрос на разрешение отправлять уведомления
    @objc func notificationRequest(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success == false {
                DispatchQueue.main.async {
                    self.view().settingItem3Switcher.isSelected.toggle()
                }
            }
            if let error = error {
                print(error)
            }
        }

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

        enableNotification()
    }

    func enableNotification(){
        // если пользователь включил уведомления в настройках
        let status = settings[3] as? Bool
        if let status {
            let center = UNUserNotificationCenter.current()
            if status {
                //включаем отправку уведомления
                let content = UNMutableNotificationContent()
                content.title = "Краткий прогноз на сегодня"
                content.body = "Днем обещается кратковременный дождь и +15 градусов тепла"
                content.sound = .default

                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)

                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                center.add(request)

            } else {
                // отключаем отправку уведомления
                center.removeAllPendingNotificationRequests()
            }
        }
    }
    
    @objc func didTap(){
        saveSettings()
        navigationController?.popViewController(animated: true)
    }
}

