//
//  PageView.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 14.06.2023.
//

import UIKit

class PageView : UIView {

    lazy var wrapperView = CVView(backgroundColor: .textBlack, isHidden: true, alpha: 0.5)

    lazy var pageViewController : UIPageViewController = {
        let controller = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }()

    lazy var pageControl : UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.isHidden = true
        return pageControl
    }()

    lazy var activityIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }()

    lazy var informationLabel = CVLabel(text: pageDescription, size: 16, weight: .semibold, color: Colors.textGray, numberOfLines: 0, textAlignment: .center, isHidden: true)

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
        self.addSubview(informationLabel)
        self.addSubview(activityIndicator)
        self.addSubview(pageControl)
        self.addSubview(pageViewController.view)
        self.addSubview(wrapperView)

    }

    func setConstraints(){
        NSLayoutConstraint.activate([

            wrapperView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            wrapperView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            wrapperView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            wrapperView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),

            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),

            pageViewController.view.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 10),
            pageViewController.view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            pageViewController.view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            pageViewController.view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0),

            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            informationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            informationLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            informationLabel.widthAnchor.constraint(equalToConstant: 250),

        ])
    }

}
