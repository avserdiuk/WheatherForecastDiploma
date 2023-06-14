//
//  Forecast24View.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 14.06.2023.
//

import UIKit

class Forecast24View : UIView {
    
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "backArrow"), for: .normal)
        return button
    }()
    
    private lazy var backButtonTitleLabel = CVButton(title: forecast24BackButtonTitleLabel, titleSize: 16, titleColor: .textGray)
    lazy var titleLabel = CVLabel(text: "Омск, Россия", size: 18, weight: .semibold)
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .clear
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews(){
        self.addSubview(backButton)
        self.addSubview(backButtonTitleLabel)
        self.addSubview(titleLabel)
        self.addSubview(tableView)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            
            backButtonTitleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            backButtonTitleLabel.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: backButtonTitleLabel.bottomAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 48),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
}
