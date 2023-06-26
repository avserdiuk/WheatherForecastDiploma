//
//  Texts.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 20.03.2023.
//

import Foundation

let permissionTitle = "Разрешить приложению  Weather использовать данные \nо местоположении вашего устройства"
let permissionSubtitle1 = "Чтобы получить более точные прогнозы \nпогоды во время движения или путешествия"
let permissionSubtitle2 = "Вы можете изменить свой выбор в любое \nвремя из меню приложения"
let permissionAcceptButtonTitle = "ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ УСТРОЙСТВА"
let permissionDeclineButtonTitle = "НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ"

let pageDescription = "Вы не разрешили доступ к автоматическому определению вашего местоположения, добавьте город через меню справа"

let settingsTitle = "Настройки"
let settingsItem1 = "Температура"
let settingsItem2 = "Скорость ветра"
let settingsItem3 = "Формат времени"
let settingsItem4 = "Уведомления"
let settingsButtonLabel = "Установить"

let mainTableHeaderAdditionTitle = "Подробнее на 24 часа"
let mainSectionHeaderTitle = "Ежедневный прогноз"
let mainSectionHeaderAdditionTitle = "7 дней"

let forecast24BackButtonTitleLabel = "Прогноз на 24 часа"
let forecast24Add1Label = "Преимущественно"
let forecast24Add2Label = "Ветер"
let forecast24Add3Label = "Атмосферные осадки"
let forecast24Add4Label = "Облачность"

let dailyWheatherBackButtonTitleLabel = "Дневная погода"
let dailyWheatherTitleLabel = "День"
let dailyWheatherRow01Label = "По ощущениям"
let dailyWheatherRow02Label = "Ветер"
let dailyWheatherRow03Label = "УФ индекс"
let dailyWheatherRow04Label = "Дождь"
let dailyWheatherRow05Label = "Облачность"

let dailyWheatherSunMoonTitleLabel = "Солнце и луна"
let dailyWheatherSunMoonLeftItem01Label = "Восход"
let dailyWheatherSunMoonLeftItem02Label = "Заход"

let dailyWheatherAirQualityTitleLabel = "Качество воздуха"
let dailyWheatherAirQualityQualityLabel = "хорошо"
let dailyWheatherAirQualityDescripntionLabel = "Качество воздуха считается удовлетворительным и загрязнения воздуха представляются незначительными в пределах нормы"

func getCondition(_ condition: String) -> String {
    switch condition {
    case "clear":
        return "Ясное небо"
    case "partly-cloudy":
        return "Малооблачно"
    case "cloudy":
        return "Местами облачно"
    case "overcast":
        return "Пасмурно"
    case "drizzle":
        return "Моросящий дождь"
    case "light-rain":
        return "Небольшой дождь"
    case "rain":
        return "Дождь"
    case "moderate-rain":
        return "Умеренный дождь"
    case "heavy-rain":
        return "Сильный дождь"
    case "continuous-heavy-rain":
        return "Длительный дождь"
    case "showers":
        return "Ливень"
    case "wet-snow":
        return "Дождь со снегом"
    case "light-snow":
        return "Небольшой снег"
    case "snow":
        return "Снег"
    case "snow-showers":
        return "Снегопад"
    case "hail":
        return "Град"
    case "thunderstorm":
        return "Гроза"
    case "thunderstorm-with-rain":
        return "Дождь с грозой"
    case "thunderstorm-with-hail":
        return "Гроза с градом"
    default:
        return "------"
    }
}

func getWindDir(_ dir: String) -> String{
    switch dir {
    case "nw":
        return "СЗ"
    case "n":
        return "С"
    case "ne":
        return "СВ"
    case "e":
        return "В"
    case "se":
        return "ЮВ"
    case "s":
        return "С"
    case "sw":
        return "ЮВ"
    case "w":
        return "З"
    case "с":
        return "Ш"
    default:
        return "------"
    }
}

func getUvIndex(_ uvIndex : Int) -> String {
    switch uvIndex {
    case 0...2:
        return "\(uvIndex) (Низкий)"
    case 3...5:
        return "\(uvIndex) (Умеренный)"
    case 6...7:
        return "\(uvIndex) (Высокий)"
    case 8...9:
        return "\(uvIndex) (Очень высокий)"
    case 11...15:
        return "\(uvIndex) (Опасный)"
    default:
        return "нет данных"
    }
}
func getCurrentHour() -> Int {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH"
    let dateInFormat = dateFormatter.string(from: NSDate() as Date)
    return Int(dateInFormat)!
}

func getCurrentHourAt3h() -> Int {
    let currentHour = getCurrentHour()
    switch currentHour {
    case 0...2:
        return 0
    case 3...5:
        return 3
    case 6...8:
        return 6
    case 9...11:
        return 9
    case 12...14:
        return 12
    case 15...17:
        return 15
    case 18...20:
        return 18
    case 21...23:
        return 21
    default:
        return 0
    }
}


