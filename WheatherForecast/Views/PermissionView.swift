//
//  PermissionView.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 13.06.2023.
//

import UIKit

final class PermissionView : UIView {

    private lazy var imageView = CVImage(imageName: "permissionImage")

    private lazy var titleLabel = CVLabel(
        text: permissionTitle, size: 16, weight: .semibold,
        color: .textWhite,
        numberOfLines: 0,
        textAlignment: .center
    )

    private lazy var subtitle1Label = CVLabel(
        text: permissionSubtitle1, size: 14, weight: .regular,
        color: .textWhite,
        numberOfLines: 0,
        textAlignment: .center
    )

    private lazy var subtitle2Label = CVLabel(
        text: permissionSubtitle2, size: 14, weight: .regular,
        color: .textWhite,
        numberOfLines: 0,
        textAlignment: .center
    )

    lazy var acceptButton = CVButton(
        title: permissionAcceptButtonTitle,
        titleSize: 12,
        titleColor: .textWhite,
        titleWeight: .semibold,
        backgroundColor: .orange,
        cornerRadius: 10
    )

    lazy var declineButton = CVButton(
        title: permissionDeclineButtonTitle,
        titleSize: 16,
        titleColor: .textWhite,
        titleWeight: .regular
    )

    override init(frame: CGRect) {
        super.init(frame: .zero)

        self.backgroundColor = Colors.accentBlue.color
        
        setViews()
        setConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setViews(){
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(subtitle1Label)
        self.addSubview(subtitle2Label)
        self.addSubview(acceptButton)
        self.addSubview(declineButton)
    }

    func setConstraints(){
        NSLayoutConstraint.activate([

            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 148),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 56),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 27),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -27),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            subtitle1Label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 56),
            subtitle1Label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 31),
            subtitle1Label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -31),
            subtitle1Label.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            subtitle2Label.topAnchor.constraint(equalTo: subtitle1Label.bottomAnchor, constant: 14),
            subtitle2Label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 31),
            subtitle2Label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -31),
            subtitle2Label.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            acceptButton.widthAnchor.constraint(equalToConstant: 340),
            acceptButton.heightAnchor.constraint(equalToConstant: 40),
            acceptButton.topAnchor.constraint(equalTo: subtitle2Label.bottomAnchor, constant: 44),
            acceptButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            declineButton.widthAnchor.constraint(equalToConstant: 340),
            declineButton.heightAnchor.constraint(equalToConstant: 40),
            declineButton.topAnchor.constraint(equalTo: acceptButton.bottomAnchor, constant: 25),
            declineButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),

        ])
    }
}
