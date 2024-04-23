//
//  Colors.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 20.03.2023.
//

import Foundation
import UIKit

enum Colors {
    case textWhite
    case textGray
    case textBlack
    case textGold
    case orange
    case accentBlue
    case backgroundWhite
    case borderBlue
    case backgroundGreen
    case transparent

    var color: UIColor {

        switch self {
            case .accentBlue :
                return UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
            case .textWhite:
                return UIColor(red: 0.973, green: 0.961, blue: 0.961, alpha: 1)
            case .orange:
                return UIColor(red: 0.949, green: 0.431, blue: 0.067, alpha: 1)
            case .textGray:
                return UIColor(red: 0.538, green: 0.513, blue: 0.513, alpha: 1)
            case .textBlack:
                return UIColor(red: 0.153, green: 0.153, blue: 0.133, alpha: 1)
            case .textGold:
                return UIColor(red: 0.965, green: 0.867, blue: 0.004, alpha: 1)
            case .backgroundWhite:
                return UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
            case .borderBlue:
                return UIColor(red: 0.671, green: 0.737, blue: 0.918, alpha: 1)
            case .backgroundGreen:
                return UIColor(red: 0.507, green: 0.792, blue: 0.501, alpha: 1)
            case .transparent:
                return UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
}

