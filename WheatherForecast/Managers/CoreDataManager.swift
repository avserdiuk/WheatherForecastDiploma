//
//  CoreDataManager.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 19.06.2023.
//

import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()

    private init () {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WheatherForecast")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // массив локаций из базы
    var locations : [Locations] = []

    // запрос в базу и получение актуального списка локаций в базе
    func reloadLocationList(){
        let locationsRequest = Locations.fetchRequest()
        do {
            let locationsFetched = try persistentContainer.viewContext.fetch(locationsRequest)
            locations = locationsFetched
        } catch {
            print(#function, error)
            locations = []
        }
    }


    // добавление новой локации
    func addLocation(name : String, longitude: Float, latitude: Float, wheather: Wheather,  complition: @escaping () -> ()){
        let newLocataion = Locations(context: persistentContainer.viewContext)
        newLocataion.name = name
        newLocataion.latitude = latitude
        newLocataion.longitude = longitude

        let wheatherFact = WheatherFact(context: persistentContainer.viewContext)
        wheatherFact.temp = Int32(wheather.fact.temp)
        wheatherFact.cloudness = wheather.fact.cloudness
        wheatherFact.condition = wheather.fact.condition
        wheatherFact.humidity = wheather.fact.humidity
        wheatherFact.windSpeed = wheather.fact.windSpeed
        newLocataion.fact = wheatherFact

        for i in 0...6 {
            let forecast = WheatherForecast(context: persistentContainer.viewContext)
            forecast.date = wheather.forecasts[i].date
            forecast.sunrise = wheather.forecasts[i].sunrise
            forecast.unixtime = Int32(wheather.forecasts[i].unixtime)
            forecast.sunset = wheather.forecasts[i].sunset
            newLocataion.addToForecast(forecast)

            let forecastPartDay = ForecastPart(context: persistentContainer.viewContext)
            forecastPartDay.name = "day"
            forecastPartDay.tempMin = Int32(wheather.forecasts[i].parts.day.tempMin)
            forecastPartDay.tempMax = Int32(wheather.forecasts[i].parts.day.tempMax)
            forecastPartDay.tempAvg = Int32(wheather.forecasts[i].parts.day.tempAvg)
            forecastPartDay.tempFeelLike = Int32(wheather.forecasts[i].parts.day.tempFeelLike)
            forecastPartDay.condition = wheather.forecasts[i].parts.day.condition
            forecastPartDay.precipitation = wheather.forecasts[i].parts.day.precipitation
            forecastPartDay.windSpeed = wheather.forecasts[i].parts.day.windSpeed
            forecastPartDay.windDir = wheather.forecasts[i].parts.day.windDir
            forecastPartDay.cloudness = wheather.forecasts[i].parts.day.cloudness
            forecastPartDay.uvIndex = Int32(wheather.forecasts[i].parts.day.uvIndex ?? 0)
            forecast.addToForecastPart(forecastPartDay)

            let forecastPartNight = ForecastPart(context: persistentContainer.viewContext)
            forecastPartNight.name = "night"
            forecastPartNight.tempMin = Int32(wheather.forecasts[i].parts.night.tempMin)
            forecastPartNight.tempMax = Int32(wheather.forecasts[i].parts.night.tempMax)
            forecastPartNight.tempAvg = Int32(wheather.forecasts[i].parts.night.tempAvg)
            forecastPartNight.tempFeelLike = Int32(wheather.forecasts[i].parts.night.tempFeelLike)
            forecastPartNight.condition = wheather.forecasts[i].parts.night.condition
            forecastPartNight.precipitation = wheather.forecasts[i].parts.night.precipitation
            forecastPartNight.windSpeed = wheather.forecasts[i].parts.night.windSpeed
            forecastPartNight.windDir = wheather.forecasts[i].parts.night.windDir
            forecastPartNight.cloudness = wheather.forecasts[i].parts.night.cloudness
            forecastPartNight.uvIndex = Int32(wheather.forecasts[i].parts.night.uvIndex ?? 0)
            forecast.addToForecastPart(forecastPartNight)

            if i <= 1 {
                for k in 0...23 {
                    let forecastHour = ForecastHours(context: persistentContainer.viewContext)
                    forecastHour.temp = Int32(wheather.forecasts[i].hours[k].temp)
                    forecastHour.feelsLike = Int32(wheather.forecasts[i].hours[k].feelsLike)
                    forecastHour.hour = Int32(wheather.forecasts[i].hours[k].hour)!
                    forecastHour.condition = wheather.forecasts[i].hours[k].condition
                    forecastHour.windSpeed = wheather.forecasts[i].hours[k].windSpeed
                    forecastHour.windDir = wheather.forecasts[i].hours[k].windDir
                    forecastHour.precipitation = wheather.forecasts[i].hours[k].precipitation
                    forecastHour.cloudness = wheather.forecasts[i].hours[k].cloudness
                    forecast.addToForecastHours(forecastHour)
                }
            }

        }


        saveContext()
        reloadLocationList()
        complition()
    }
}
