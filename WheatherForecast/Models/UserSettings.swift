//
//  UserSettings.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 15.06.2023.
//

import Foundation

enum Temp: String {
    case f = "F"
    case c = "C"
}

enum WindSpeed: String {
    case mi = "MI"
    case km = "KM"
}

enum TimeFormat: Int {
    case half = 12
    case full = 24
}

struct Settings {
    var temp : String
    var windSpeed : String
    var timeFormat : Int
    var pushNotification : Bool
}

