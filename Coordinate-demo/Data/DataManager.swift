//
//  DataManager.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import Foundation
import CoreData

class DataManager: NSObject {
    
    let persistentContainer: NSPersistentContainer
    
    override init() {
        self.persistentContainer = NSPersistentContainer(name: "DataModel")
        
        super.init()
    }
    
    func start(with completion: @escaping () -> Void = {}) {
        self.persistentContainer.loadPersistentStores(completionHandler: { [weak self] _, error in
            
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            self?.preloadData()
            
            completion()
        })
    }
    
    // MARK: - Core Data stack
    
    private func preloadData() {
        
        // Check if the default data already exists...
        let teams = self.getTeams()
        let drivers = self.getDrivers()
        let profile = self.getProfile()
        
        if teams.isEmpty || drivers.isEmpty || profile == nil {
            
            self.deleteAll()
            self.saveContext()
            
            // Create Drivers
            let driver1 = Driver(context: self.persistentContainer.viewContext)
            driver1.name = "Driver 1"
            
            let driver2 = Driver(context: self.persistentContainer.viewContext)
            driver2.name = "Driver 2"
            
            let driver3 = Driver(context: self.persistentContainer.viewContext)
            driver3.name = "Driver 3"
            
            let driver4 = Driver(context: self.persistentContainer.viewContext)
            driver4.name = "Driver 4"
            
            let driver5 = Driver(context: self.persistentContainer.viewContext)
            driver5.name = "Driver 5"
            
            let driver6 = Driver(context: self.persistentContainer.viewContext)
            driver6.name = "Driver 6"
            
            // Create Teams, CoreData will create Drivers relationships automatically
            let teamA = Team(context: self.persistentContainer.viewContext)
            teamA.name = "Team A"
            teamA.addToDrivers([driver1, driver2])
            
            let teamB = Team(context: self.persistentContainer.viewContext)
            teamB.name = "Team B"
            teamB.addToDrivers([driver3, driver4])
            
            let teamC = Team(context: self.persistentContainer.viewContext)
            teamC.name = "Team C"
            teamC.addToDrivers([driver5, driver6])
            
            // Create Profile
            let profile = Profile(context: self.persistentContainer.viewContext)
            profile.name = "Coordinate Ambassador"
            
            // Save
            self.saveContext()
        }
    
    }
    
    // MARK: - Core Data Utilities
    
    private func saveContext() {
        let context = self.persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func deleteAll() {
        delete(entity: "Profile")
        delete(entity: "Driver")
        delete(entity: "Team")
    }
    
    private func delete(entity: String) {
        let managedObjectContext = self.persistentContainer.viewContext
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do {
            // Execute Request
            try managedObjectContext.execute(request)
        } catch {
            print("Unable to delete entity \(entity).")
        }
    }
    
    private func fetchRecordsForEntity(_ entity: String) -> [NSManagedObject] {
        
        let managedObjectContext = self.persistentContainer.viewContext
        
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        // Helpers
        var result = [NSManagedObject]()
        
        do {
            // Execute Fetch Request
            let records = try managedObjectContext.fetch(fetchRequest)
            
            if let records = records as? [NSManagedObject] {
                result = records
            }
            
        } catch {
            print("Unable to fetch managed objects for entity \(entity).")
        }
        
        return result
    }
    
    private func fetchRecordForEntity(_ entity: String, with predicate: NSPredicate) -> [NSManagedObject] {
        
        let managedObjectContext = self.persistentContainer.viewContext
        
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.predicate = predicate
        
        // Helpers
        var result = [NSManagedObject]()
        
        do {
            // Execute Fetch Request
            let records = try managedObjectContext.fetch(fetchRequest)
            
            if let records = records as? [NSManagedObject] {
                result = records
            }
            
        } catch {
            print("Unable to fetch managed objects for entity \(entity).")
        }
        
        return result
    }
    
    // MARK: - Public Interface
    
    func getTeams() -> [Team] {
        var teams = [Team]()
        
        if let fetchedTeams = fetchRecordsForEntity("Team") as? [Team] {
            teams = fetchedTeams.sorted(by: { lhs, rhs in
                if let lhsName = lhs.name, let rhsName = rhs.name {
                    return lhsName < rhsName
                } else {
                    return false
                }
            })
        }
        
        return teams
    }
    
    func getTeam(with name: String) -> Team? {
        let predicate = NSPredicate(format: "name == %@", name)
        
        let fetchedTeams = fetchRecordForEntity("Team", with: predicate) as? [Team]

        return fetchedTeams?.first
    }
    
    func getDrivers() -> [Driver] {
        var drivers = [Driver]()
        
        if let fetchedDrivers = fetchRecordsForEntity("Driver") as? [Driver] {
            drivers = fetchedDrivers.sorted(by: { lhs, rhs in
                if let lhsName = lhs.name, let rhsName = rhs.name {
                    return lhsName < rhsName
                } else {
                    return false
                }
            })
        }
        
        return drivers
    }
    
    func getProfile() -> Profile? {
        let fetchedProfiles = fetchRecordsForEntity("Profile") as? [Profile]
        
        return fetchedProfiles?.first
    }
    
    func getProfileFavorites() -> ([Team], [Driver])? {
        return getProfile()?.getFavorites()
    }
    
    func setFavorite(team: Team) {
        guard let profile = getProfile() else { return }
        
        profile.addToFavorite_teams(team)
    }
    
    func unsetFavorite(team: Team) {
        guard let profile = getProfile() else { return }
        
        profile.removeFromFavorite_teams(team)
    }
    
    func setFavorite(driver: Driver) {
        guard let profile = getProfile() else { return }
        
        profile.addToFavorite_drivers(driver)
    }
    
    func unsetFavorite(driver: Driver) {
        guard let profile = getProfile() else { return }
        
        profile.removeFromFavorite_drivers(driver)
    }
    
    func save() {
        self.saveContext()
    }
}
