//
//  CoreDataWheatherTableHeader.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 22.06.2023.
//


import UIKit

class WheatherTableHeader: UITableViewHeaderFooterView {

    weak var viewController : UIViewController?
    var titleLabel : String?
    var indexMass : [Int] = []
    var location: Locations?

    private lazy var wrapper = CVView()

    private lazy var view = CVView(backgroundColor: .accentBlue,cornerRadius: 5)
    private lazy var elipseImageView = CVImage(imageName: "elipse")
    private lazy var sunRiseLabel = CVLabel(text: "06:00", size: 15, weight: .semibold, color: .textWhite)
    private lazy var sunSetLabel = CVLabel(text: "19:00", size: 15, weight: .semibold, color: .textWhite)

    private lazy var stackView = CVStackView(axis: .vertical, spacing: 9, alignment: .center)

    private lazy var dayNightTempLabel = CVLabel(text: "7°/13°", size: 16, weight: .regular, color: .textWhite)
    private lazy var nowTempLabel = CVLabel(text: "13°", size: 36, weight: .semibold, color: .textWhite)
    private lazy var nowDescLabel = CVLabel(text: "Возможен небольшой дождь", size: 18, weight: .regular, color: .textWhite)

    private lazy var additionStackView = CVStackView(axis: .horizontal, spacing: 20)

    private lazy var sunView = CVView()
    private lazy var sunViewImageView = CVImage(imageName: "sun")
    private lazy var sunViewLabel = CVLabel(text: "0", size: 14, weight: .regular, color: .textWhite)

    private lazy var windView = CVView()
    private lazy var windViewImageView = CVImage(imageName: "wind")
    private lazy var windViewLabel = CVLabel(text: "3 м/с", size: 14, weight: .regular, color: .textWhite)

    private lazy var rainView = CVView()
    private lazy var rainViewImageView = CVImage(imageName: "rain")
    private lazy var rainViewLabel = CVLabel(text: "75 %", size: 14, weight: .regular, color: .textWhite)

    private lazy var dataTimeLabel = CVLabel(text: "17:48,  пт 16 апреля", size: 16, weight: .regular, color: .textGold)

    private lazy var more24hButton = CVButton(
        title: mainTableHeaderAdditionTitle,
        titleSize: 16,
        titleWeight: .regular)

    private lazy var more24hButtonLine = CVView(backgroundColor: .textBlack)

    private lazy var collectionLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()

    private lazy var more24hCollectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collection.register(WheatherCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = Colors.transparent.color
        collection.contentInset
        = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return collection
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setViews()
        setConstraints()
        getIndixesMass()

        more24hButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getIndixesMass(){
        let currentHour = getCurrentHour()

        if currentHour == 0 {
            for i in currentHour...23 {
                indexMass.append(i)
            }
        } else {
            for i in currentHour...23 {
                indexMass.append(i)
            }
            for k in 0..<currentHour {
                indexMass.append(k)
            }
        }
    }

    func setup(_ location : Locations){

        let forecast = location.forecast?.allObjects as! [WheatherForecast]
        var parts = forecast[0].forecastPart?.allObjects as! [ForecastPart]
        parts.sort{ $0.name! < $1.name! }

        self.sunRiseLabel.text = "\(getCurrentFormatTime(dateAsString: forecast[0].sunrise ?? ""))"
        self.sunSetLabel.text = "\(getCurrentFormatTime(dateAsString: forecast[0].sunset ?? ""))"
        self.nowTempLabel.text = "\(location.fact?.temp.SСomputed() ?? 99)"
        self.nowDescLabel.text = getCondition(location.fact?.condition ?? "")
        self.sunViewLabel.text = "\(Int((location.fact?.cloudness ?? 0.0)*100))%"
        self.windViewLabel.text = "\(location.fact?.windSpeed.SСomputed() ?? 99) \(getCurrentWindSpeed())"
        self.rainViewLabel.text = "\(Int(location.fact?.humidity ?? 99))%"
        self.dataTimeLabel.text = "\(self.getCurrentTime())"
        self.dayNightTempLabel.text = "\(parts[1].tempMin.SСomputed())°/\(parts[0].tempMax.SСomputed())°"
    }

    @objc func didTap(){
        let controller = Forecast24ViewController()
        controller.viewController = viewController
        controller.location = location
        controller.view().titleLabel.text = titleLabel
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }

    func getCurrentTime() -> String {

        let settings = UserDefaults.standard.array(forKey: "settings") ?? [] // берем актуальные настроки
        let status = settings[2] as? Bool

        let dateFormatter = DateFormatter()
        if status == false {
            dateFormatter.dateFormat = "HH:mm, E dd MMMM "
        } else {
            dateFormatter.dateFormat = "h:mm a, E dd MMMM "
        }

        let dateInFormat = dateFormatter.string(from: NSDate() as Date)
        return dateInFormat
    }

    func getCurrentHour() -> Int {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let dateInFormat = dateFormatter.string(from: NSDate() as Date)
        return Int(dateInFormat)!
    }

    func setViews(){
        addSubview(wrapper)
        wrapper.addSubview(view)
        view.addSubview(elipseImageView)
        view.addSubview(sunRiseLabel)
        view.addSubview(sunSetLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(dayNightTempLabel)
        stackView.addArrangedSubview(nowTempLabel)
        stackView.addArrangedSubview(nowDescLabel)

        stackView.addArrangedSubview(additionStackView)

        sunView.addSubview(sunViewImageView)
        sunView.addSubview(sunViewLabel)
        additionStackView.addArrangedSubview(sunView)

        windView.addSubview(windViewImageView)
        windView.addSubview(windViewLabel)
        additionStackView.addArrangedSubview(windView)

        rainView.addSubview(rainViewImageView)
        rainView.addSubview(rainViewLabel)
        additionStackView.addArrangedSubview(rainView)

        stackView.addArrangedSubview(dataTimeLabel)

        wrapper.addSubview(more24hButton)
        wrapper.addSubview(more24hButtonLine)
        wrapper.addSubview(more24hCollectionView)
    }

    func setConstraints(){
        NSLayoutConstraint.activate([

            wrapper.heightAnchor.constraint(equalToConstant: 385),

            wrapper.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            wrapper.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            wrapper.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            wrapper.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),

            view.heightAnchor.constraint(equalToConstant: 212),

            view.topAnchor.constraint(equalTo: wrapper.topAnchor, constant: 0),
            view.leftAnchor.constraint(equalTo: wrapper.leftAnchor, constant: 16),
            view.rightAnchor.constraint(equalTo: wrapper.rightAnchor, constant: -16),

            elipseImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            elipseImageView.widthAnchor.constraint(equalToConstant: 300),
            elipseImageView.heightAnchor.constraint(equalToConstant: 246),
            elipseImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 17),

            sunRiseLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 17),
            sunRiseLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 167),

            sunSetLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -17),
            sunSetLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 167),

            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 33),

            additionStackView.heightAnchor.constraint(equalToConstant: 20),

            sunView.heightAnchor.constraint(equalToConstant: 20),

            sunViewImageView.widthAnchor.constraint(equalToConstant: 21),
            sunViewImageView.heightAnchor.constraint(equalToConstant: 18),
            sunViewImageView.topAnchor.constraint(equalTo: sunView.topAnchor, constant: 0),
            sunViewImageView.leftAnchor.constraint(equalTo: sunView.leftAnchor, constant: 0),

            sunViewLabel.topAnchor.constraint(equalTo: sunView.topAnchor, constant: 0),
            sunViewLabel.leftAnchor.constraint(equalTo: sunViewImageView.rightAnchor, constant: 5),
            sunViewLabel.rightAnchor.constraint(equalTo: sunView.rightAnchor, constant: 0),

            windView.heightAnchor.constraint(equalToConstant: 20),

            windViewImageView.widthAnchor.constraint(equalToConstant: 25),
            windViewImageView.heightAnchor.constraint(equalToConstant: 16),
            windViewImageView.leftAnchor.constraint(equalTo: windView.leftAnchor, constant: 0),
            windViewImageView.topAnchor.constraint(equalTo: windView.topAnchor, constant: 0),

            windViewLabel.topAnchor.constraint(equalTo: windView.topAnchor, constant: 0),
            windViewLabel.leftAnchor.constraint(equalTo: windViewImageView.rightAnchor, constant: 5),
            windViewLabel.rightAnchor.constraint(equalTo: windView.rightAnchor, constant: 0),

            rainView.heightAnchor.constraint(equalToConstant: 20),

            rainViewImageView.widthAnchor.constraint(equalToConstant: 13),
            rainViewImageView.heightAnchor.constraint(equalToConstant: 15),
            rainViewImageView.leftAnchor.constraint(equalTo: rainView.leftAnchor, constant: 0),
            rainViewImageView.topAnchor.constraint(equalTo: rainView.topAnchor, constant: 0),

            rainViewLabel.topAnchor.constraint(equalTo: rainView.topAnchor, constant: 0),
            rainViewLabel.leftAnchor.constraint(equalTo: rainViewImageView.rightAnchor, constant: 5),
            rainViewLabel.rightAnchor.constraint(equalTo: rainView.rightAnchor, constant: 0),

            more24hButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
            more24hButton.rightAnchor.constraint(equalTo: wrapper.rightAnchor, constant: -16),

            more24hButtonLine.heightAnchor.constraint(equalToConstant: 0.5),
            more24hButtonLine.widthAnchor.constraint(equalToConstant: 175),
            more24hButtonLine.centerXAnchor.constraint(equalTo: more24hButton.centerXAnchor),
            more24hButtonLine.bottomAnchor.constraint(equalTo: more24hButton.bottomAnchor, constant: -6),

            more24hCollectionView.topAnchor.constraint(equalTo: more24hButton.bottomAnchor, constant: 10),
            more24hCollectionView.leftAnchor.constraint(equalTo: wrapper.leftAnchor, constant: 0),
            more24hCollectionView.rightAnchor.constraint(equalTo: wrapper.rightAnchor, constant: 0),
            more24hCollectionView.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor, constant: -24)
        ])
    }

}

extension WheatherTableHeader : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! WheatherCollectionViewCell

        if indexPath.item == 1 {
            cell.contentView.backgroundColor = Colors.accentBlue.color

            let label = cell.viewWithTag(1) as? UILabel
            label?.textColor = UIColor.white

            let label2 = cell.viewWithTag(2) as? UILabel
            label2?.textColor = UIColor.white
        }

        if let location = location {
            cell.setup(location, indexMass[indexPath.item])
        }

        return cell
    }
}

extension WheatherTableHeader : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 42, height: 84)
    }
}

