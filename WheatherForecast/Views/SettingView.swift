//
//  SettingView.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 14.06.2023.
//

import UIKit

class SettingView : UIView {
    
    private lazy var cloud1ImageView = CVImage(imageName: "cloud1")
    private lazy var cloud2ImageView = CVImage(imageName: "cloud2")
    private lazy var cloud3ImageView = CVImage(imageName: "cloud3")
    
    private lazy var wrapperView = CVView(backgroundColor: .backgroundWhite, cornerRadius: 10)
    private lazy var settingTitle = CVLabel(text: settingsTitle, size: 18, weight: .regular, color: .textBlack)
    
    private lazy var settingItemStack = CVStackView(axis: .vertical, spacing: 30)
    private lazy var settingItem1Label = CVLabel(text: settingsItem1, size: 16, weight: .regular, color: .textGray)
    private lazy var settingItem2Label = CVLabel(text: settingsItem2, size: 16, weight: .regular, color: .textGray)
    private lazy var settingItem3Label = CVLabel(text: settingsItem3, size: 16, weight: .regular, color: .textGray)
    private lazy var settingItem4Label = CVLabel(text: settingsItem4, size: 16, weight: .regular, color: .textGray)
    
    private lazy var settingItemStack2 = CVStackView(axis: .vertical, spacing: 18)
    private lazy var settingItem1Switcher = CVSwithcer("temp")
    private lazy var settingItem2Switcher = CVSwithcer("wind")
    private lazy var settingItem3Switcher = CVSwithcer("time")
    private lazy var settingItem4Switcher = CVSwithcer("notif")
    
    lazy var button = CVButton(
        title: settingsButtonLabel,
        titleSize: 16,
        titleColor: .textWhite,
        titleWeight: .regular,
        backgroundColor: .orange,
        cornerRadius: 10
    )
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.backgroundColor = Colors.accentBlue.color
        setViews()
        setConstraints()
        cloudAnimation()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cloudAnimation(){
        UIView.animate(withDuration: 5, delay: 0) {
            self.cloud1ImageView.center = CGPoint(x: 50, y: 0)
            self.cloud1ImageView.alpha = 0.4
            
            self.cloud2ImageView.center = CGPoint(x: -50, y: 0)
            self.cloud2ImageView.alpha = 0.6
            
            self.cloud3ImageView.center = CGPoint(x: 70, y: 0)
            self.cloud3ImageView.alpha = 0.5
        }
    }
    
    func setViews(){
        self.addSubview(cloud1ImageView)
        self.addSubview(cloud2ImageView)
        self.addSubview(cloud3ImageView)
        self.addSubview(wrapperView)
        wrapperView.addSubview(settingTitle)
        wrapperView.addSubview(settingItemStack)
        settingItemStack.addArrangedSubview(settingItem1Label)
        settingItemStack.addArrangedSubview(settingItem2Label)
        settingItemStack.addArrangedSubview(settingItem3Label)
        settingItemStack.addArrangedSubview(settingItem4Label)
        wrapperView.addSubview(settingItemStack2)
        settingItemStack2.addArrangedSubview(settingItem1Switcher)
        settingItemStack2.addArrangedSubview(settingItem2Switcher)
        settingItemStack2.addArrangedSubview(settingItem3Switcher)
        settingItemStack2.addArrangedSubview(settingItem4Switcher)
        self.addSubview(button)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            
            cloud1ImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 37),
            cloud1ImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            cloud1ImageView.heightAnchor.constraint(equalToConstant: 58),
            cloud1ImageView.widthAnchor.constraint(equalToConstant: 245),
            
            cloud2ImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 121),
            cloud2ImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            cloud2ImageView.heightAnchor.constraint(equalToConstant: 94),
            cloud2ImageView.widthAnchor.constraint(equalToConstant: 182),
            
            cloud3ImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 652),
            cloud3ImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cloud3ImageView.heightAnchor.constraint(equalToConstant: 65),
            cloud3ImageView.widthAnchor.constraint(equalToConstant: 216),
            
            wrapperView.widthAnchor.constraint(equalToConstant: 320),
            wrapperView.heightAnchor.constraint(equalToConstant: 330),
            wrapperView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            wrapperView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            settingTitle.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 27),
            settingTitle.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: 20),
            
            settingItemStack.topAnchor.constraint(equalTo: settingTitle.bottomAnchor, constant: 20),
            settingItemStack.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: 20),
            
            settingItemStack2.topAnchor.constraint(equalTo: settingTitle.bottomAnchor, constant: 20),
            settingItemStack2.rightAnchor.constraint(equalTo: wrapperView.rightAnchor, constant: -30),
            
            button.topAnchor.constraint(equalTo: settingItemStack.bottomAnchor, constant: 40),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 240),
            
        ])
    }
    
}
