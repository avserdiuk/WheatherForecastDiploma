//
//  CustomSectionHeader.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 21.03.2023.
//

import UIKit

class CustomSectionHeader: UITableViewHeaderFooterView {

    private lazy var titleLabel = CVLabel(text: mainSectionHeaderTitle, size: 18, weight: .semibold)
    private lazy var dayCountLabel = CVLabel(text: mainSectionHeaderAdditionTitle, size: 16, weight: .regular)

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setViews()
        setConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setViews(){
        addSubview(titleLabel)
        addSubview(dayCountLabel)
    }

    func setConstraints(){
        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),

            dayCountLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            dayCountLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            dayCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)

        ])
    }
}
