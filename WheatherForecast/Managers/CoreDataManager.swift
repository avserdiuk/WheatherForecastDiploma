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

    func clearAll(){
        let locationsRequest = Locations.fetchRequest()
        do {
            let locationsFetched = try persistentContainer.viewContext.fetch(locationsRequest)
            locations = locationsFetched
            locationsFetched.forEach { location in
                persistentContainer.viewContext.delete(location)
            }
            saveContext()
        } catch {
            print(#function, error)
        }
    }

    // добавление новой локации
    func addLocation(name : String, longitude: Float, latitude: Float, wheather: Wheather,  complition: @escaping () -> ()){
        let newLocataion = Locations(context: persistentContainer.viewContext)
        newLocataion.name = name
        newLocataion.latitude = latitude
        newLocataion.longitude = longitude
        newLocataion.lastUpdate = Int32(NSDate().timeIntervalSince1970)

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

    func deleteLocation(location: Locations, complition: @escaping () -> ()){
        let locationsRequest = Locations.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", "\(location.name!)")
        locationsRequest.predicate = predicate
        do {
            let locationsFetched = try persistentContainer.viewContext.fetch(locationsRequest)
            persistentContainer.viewContext.delete(locationsFetched.first!)
            reloadLocationList()
            saveContext()
            complition()
        } catch {
            print(#function, error)
        }

    }

    func updateLocation(location: Locations, wheather: Wheather,  complition: @escaping () -> ()){
        let predicate = NSPredicate(format: "name == %@", "\(location.name!)")
        let locationsRequest = Locations.fetchRequest()
        locationsRequest.predicate = predicate
        do {
            let _ = try persistentContainer.viewContext.fetch(locationsRequest)
            location.lastUpdate = Int32(NSDate().timeIntervalSince1970)

            location.fact!.temp = Int32(wheather.fact.temp)
            location.fact!.cloudness = wheather.fact.cloudness
            location.fact!.condition = wheather.fact.condition
            location.fact!.humidity = wheather.fact.humidity
            location.fact!.windSpeed = wheather.fact.windSpeed

            var forecast = location.forecast?.allObjects as! [WheatherForecast]
            forecast.sort{ $0.date! < $1.date! }

            for i in 0...6 {
                forecast[i].date = wheather.forecasts[i].date
                forecast[i].sunrise = wheather.forecasts[i].sunrise
                forecast[i].unixtime = Int32(wheather.forecasts[i].unixtime)
                forecast[i].sunset = wheather.forecasts[i].sunset

                var parts = forecast[i].forecastPart?.allObjects as! [ForecastPart]
                parts.sort{ $0.name! < $1.name! }

                parts[0].tempMin = Int32(wheather.forecasts[i].parts.day.tempMin)
                parts[0].tempMax = Int32(wheather.forecasts[i].parts.day.tempMax)
                parts[0].tempAvg = Int32(wheather.forecasts[i].parts.day.tempAvg)
                parts[0].tempFeelLike = Int32(wheather.forecasts[i].parts.day.tempFeelLike)
                parts[0].condition = wheather.forecasts[i].parts.day.condition
                parts[0].precipitation = wheather.forecasts[i].parts.day.precipitation
                parts[0].windSpeed = wheather.forecasts[i].parts.day.windSpeed
                parts[0].windDir = wheather.forecasts[i].parts.day.windDir
                parts[0].cloudness = wheather.forecasts[i].parts.day.cloudness
                parts[0].uvIndex = Int32(wheather.forecasts[i].parts.day.uvIndex ?? 0)

                parts[1].tempMin = Int32(wheather.forecasts[i].parts.night.tempMin)
                parts[1].tempMax = Int32(wheather.forecasts[i].parts.night.tempMax)
                parts[1].tempAvg = Int32(wheather.forecasts[i].parts.night.tempAvg)
                parts[1].tempFeelLike = Int32(wheather.forecasts[i].parts.night.tempFeelLike)
                parts[1].condition = wheather.forecasts[i].parts.night.condition
                parts[1].precipitation = wheather.forecasts[i].parts.night.precipitation
                parts[1].windSpeed = wheather.forecasts[i].parts.night.windSpeed
                parts[1].windDir = wheather.forecasts[i].parts.night.windDir
                parts[1].cloudness = wheather.forecasts[i].parts.night.cloudness
                parts[1].uvIndex = Int32(wheather.forecasts[i].parts.night.uvIndex ?? 0)

                if i <= 1 {
                    for k in 0...23 {
                        var forecastIndex = forecast[i].forecastHours?.allObjects as! [ForecastHours]
                        forecastIndex.sort { $0.hour < $1.hour }
                        forecastIndex[k].temp = Int32(wheather.forecasts[i].hours[k].temp)
                        forecastIndex[k].feelsLike = Int32(wheather.forecasts[i].hours[k].feelsLike)
                        forecastIndex[k].hour = Int32(wheather.forecasts[i].hours[k].hour)!
                        forecastIndex[k].condition = wheather.forecasts[i].hours[k].condition
                        forecastIndex[k].windSpeed = wheather.forecasts[i].hours[k].windSpeed
                        forecastIndex[k].windDir = wheather.forecasts[i].hours[k].windDir
                        forecastIndex[k].precipitation = wheather.forecasts[i].hours[k].precipitation
                        forecastIndex[k].cloudness = wheather.forecasts[i].hours[k].cloudness
                    }
                }

            }

        } catch {
            print(#function, error)
        }

        saveContext()
        reloadLocationList()
        complition()
    }


}
