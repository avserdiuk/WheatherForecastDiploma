//
//  24hViewCell.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 29.04.2024.
//

import Foundation
import UIKit

class Block24hViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var weatherPoint: WeatherPoint?
    
    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(Cell24hCollectionViewCell.self, forCellWithReuseIdentifier: "default")
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(collection)
        
        NSLayoutConstraint.activate([
        
            collection.heightAnchor.constraint(equalToConstant: 69),
            collection.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            collection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            collection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            collection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath) as! Cell24hCollectionViewCell
        if indexPath.row == 1 {
            cell.backgroundColor = UIColor(cgColor: CGColor(red: 124/255, green: 201/255, blue: 242/155, alpha: 0.7))
            cell.layer.borderWidth = 1
            cell.layer.borderColor = CGColor(red: 120/255, green: 198/255, blue: 240/155, alpha: 1)
        }
        if let wp = weatherPoint {
            cell.setupWith(wp, index: indexPath.item) // TODO: разобраться в корректной передаче индекса относительно текущего часа
        }
        return cell
    }
    
    func setupWith(_ weatherPoint: WeatherPoint) {
        self.weatherPoint = weatherPoint
    }
    
}
