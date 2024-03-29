//
//  DriversDetailsCoordinator.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import Coordinate

class DriversDetailsCoordinator: Coordinator<DriversDetailsViewController>, HasDependencies {
    
    var dependencies: AppDependencies?
    
    var driver: Driver?

    override func start(with completion: @escaping () -> Void = {}) {
        super.start(with: completion)
        
        rootViewController.driver = driver
    }
    
    /*
        Very important to override this method, because it is called everytime the Coordinator is presented.
        If you do not update the data, the cached UIViewController will display the previous data
    */
    override func activate() {
        super.activate()
        
        rootViewController.driver = driver
    }
    
    // MARK: - Events
    
    override func interceptEvent(_ event: CoordinateEvents) -> Bool {
        
        if let event = event as? AppEvents.Drivers {
            if case .setFavorite(let driver) = event {
                dependencies?.dataManager.setFavorite(driver: driver)
            } else if case .unsetFavorite(let driver) = event {
                dependencies?.dataManager.unsetFavorite(driver: driver)
            }
        }
        
        return false
    }
}
