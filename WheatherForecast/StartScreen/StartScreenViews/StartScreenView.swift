//
//  StartScreenView.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 23.10.2024.
//

import UIKit

class StartScreenView : UIView {
    
    lazy var searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.searchBarStyle = .minimal
        bar.placeholder = "Поиск локации"
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    lazy var welcomeView: UIView = {
        let view = WelcomeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    lazy var table: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.isHidden = true
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    private lazy var trademarkView: UIView = {
        let view = AppleWeatherTrademarkView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews(){
        backgroundColor = UIColor(named: "background")
        addSubview(searchBar)
        addSubview(welcomeView)
        addSubview(table)
        addSubview(trademarkView)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: super.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.centerXAnchor.constraint(equalTo: super.centerXAnchor),
            searchBar.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 12),
            searchBar.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: -12),
            searchBar.heightAnchor.constraint(equalToConstant: 46),
            
            welcomeView.centerXAnchor.constraint(equalTo: super.centerXAnchor),
            welcomeView.centerYAnchor.constraint(equalTo: super.centerYAnchor),
            welcomeView.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 24),
            welcomeView.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: -24),
            
            table.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            table.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 24),
            table.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: -24),
            table.bottomAnchor.constraint(equalTo: super.safeAreaLayoutGuide.bottomAnchor, constant: -55),
            
            trademarkView.topAnchor.constraint(equalTo: table.bottomAnchor, constant: 5),
            trademarkView.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 24),
            trademarkView.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: -24),
            trademarkView.bottomAnchor.constraint(equalTo: super.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
}
