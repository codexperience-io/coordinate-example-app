//
//  TeamsDetailsCoordinator.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import Coordinate

class TeamsDetailsCoordinator: Coordinator<TeamsDetailsViewController>, HasDependencies {
    
    var dependencies: AppDependencies?
    
    var team: Team?
    
    override func start(with completion: @escaping () -> Void = {}) {
        super.start(with: completion)
        
        rootViewController.team = team
    }
    
    /*
     Very important to override this method, because it is called everytime the Coordinator is presented.
     If you do not update the data, the cached UIViewController will display the previous data
     */
    override func activate() {
        super.activate()
        
        rootViewController.team = team
    }
    
    // MARK: - Events
    
    override func interceptEvent(_ event: CoordinateEvents) -> Bool {
        
        if let event = event as? AppEvents.Teams {
            if case .setFavorite(let team) = event {
                dependencies?.dataManager.setFavorite(team: team)
            } else if case .unsetFavorite(let team) = event {
                dependencies?.dataManager.unsetFavorite(team: team)
            }
        }
        
        return false
    }
}
