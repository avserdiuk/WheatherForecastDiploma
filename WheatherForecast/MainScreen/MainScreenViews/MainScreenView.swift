//
//  MainScreenView.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 23.10.2024.
//

import UIKit

class MainScreenView : UIView {
    
    lazy var tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    private let time : String = {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let hoursMinutesString = dateFormatter.string(from: date)
        return hoursMinutesString
    }()
    
    private lazy var trademarkView: UIView = {
        let view = AppleWeatherTrademarkView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = UIColor(named: "background")
        addSubview(tableView)
        addSubview(trademarkView)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: super.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 24),
            tableView.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: -24),
            tableView.bottomAnchor.constraint(equalTo: super.safeAreaLayoutGuide.bottomAnchor, constant: -55),
            
            trademarkView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 5),
            trademarkView.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 24),
            trademarkView.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: -24),
            trademarkView.bottomAnchor.constraint(equalTo: super.safeAreaLayoutGuide.bottomAnchor, constant: 0)
            
        ])
    }
}
