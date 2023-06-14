//
//  CustomUIViews.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 21.03.2023.
//

import Foundation
import UIKit

class CVLabel : UILabel {

    init(
        text: String,
        size : CGFloat,
        weight: Font,
        color: Colors = .textBlack,
        numberOfLines: Int = 1,
        textAlignment: NSTextAlignment = .left,
        tag : Int = 0,
        isHidden : Bool = false
    ){
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.font = UIFont(name: "\(weight.rawValue)", size: size)
        self.textColor = color.color
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
        self.tag = tag
        self.isHidden = isHidden
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CVImage : UIImageView {
    init(imageName: String){
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image = UIImage(named: imageName)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CVButton : UIButton {
    init(title: String, titleSize: CGFloat, titleColor : Colors = .textBlack, titleWeight: Font = .regular,  backgroundColor: Colors = .transparent, cornerRadius: CGFloat = 0){
        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont(name: "\(titleWeight.rawValue)", size: titleSize)
        self.setTitleColor(titleColor.color, for: .normal)
        self.backgroundColor = backgroundColor.color
        self.layer.cornerRadius = cornerRadius

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CVView : UIView {
    init(backgroundColor: Colors = .transparent, cornerRadius: CGFloat = 0, isHidden: Bool = false, alpha: CGFloat = 1){
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor.color
        self.layer.cornerRadius = cornerRadius
        self.isHidden = isHidden
        self.alpha = alpha
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CVStackView : UIStackView {
    init(axis : NSLayoutConstraint.Axis = .horizontal, spacing : CGFloat = 0, alignment : UIStackView.Alignment = .fill){
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class CVSwithcer : UIButton {
    @objc func didTap(){
        self.isSelected.toggle()
    }

    init(_ place : String){
        super.init(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(UIImage(named: "\(place)_stateOFF"), for: .selected)
        self.setImage(UIImage(named: "\(place)_stateON"), for: .normal)
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
