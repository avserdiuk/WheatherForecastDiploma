//
//  CustomDailyWheatherTableHeader.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 24.03.2023.
//

import UIKit

class CustomDailyWheatherTableHeader: UITableViewHeaderFooterView {

    weak var delegate: DailyWheatherViewController!
    var wheather : Wheather?
    var index : Int?

    private lazy var collectionViewFloyLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFloyLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collection.dataSource = self
        collection.delegate = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collection.register(CustomDailyWheatherCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(collectionView)
        
        setConstraints()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.collectionView.scrollToItem(at: IndexPath(item: self.index ?? 0, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setConstraints(){
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: 55),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
    }

}

extension CustomDailyWheatherTableHeader : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        wheather?.forecasts.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let wheather else { return UICollectionViewCell()}

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomDailyWheatherCollectionViewCell
        cell.setup(wheather, indexPath)

        if indexPath.row == index {
            cell.layer.backgroundColor = Colors.accentBlue.color.cgColor
            cell.layer.cornerRadius = 5
            let label = cell.viewWithTag(1) as? UILabel
            label?.textColor = UIColor.white
            return cell
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 88, height: 36)
    }
}

extension CustomDailyWheatherTableHeader : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.index = indexPath.item
        delegate.view().tableView.reloadSections(IndexSet(integer: 0), with: .fade)
    }
}
