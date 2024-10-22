//
//  CoreDataManager.swift
//  WheatherForecast
//
//  Created by Алексей Сердюк on 21.10.2024.
//

import CoreData

class CoreDataManager{
    
    static let shared = CoreDataManager()
    private init(){}
    
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
    
    func addLocation(_ location: Location){
        let newLocation = Locations(context: persistentContainer.viewContext)
        newLocation.city = location.city
        newLocation.country = location.country
        newLocation.latitude = location.latitude
        newLocation.longitude = location.longitude
        saveContext()
    }
    
    func getLocations(complition: @escaping ([Location]?)->()){
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Locations> = Locations.fetchRequest()
        do {
            let objects = try context.fetch(fetchRequest)
            
            guard objects != [] else {
                complition(nil)
                return
            }
            
            var locations : [Location] = []
            
            objects.forEach {
                locations.append(Location(country: $0.country!, city: $0.city!, latitude: $0.latitude!, longitude: $0.longitude!))
            }
    
            complition(locations)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func removeAll(){
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Locations> = Locations.fetchRequest()
        
        do {
            let object = try context.fetch(fetchRequest)
            object.forEach { locations in
                context.delete(locations)
            }
           
            saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func removeItem(_ item: Location){
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Locations> = Locations.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "city == %@", item.city)
        
        do {
            let object = try context.fetch(fetchRequest)
            context.delete(object.first!)
            
            saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
}
