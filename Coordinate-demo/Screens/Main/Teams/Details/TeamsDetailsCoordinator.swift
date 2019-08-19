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
    
    override func setFavorite(team: Team) {
        dependencies?.dataManager.setFavorite(team: team)
        
        // To make sure that the parent Coordinators will receive this message, we need to do this
        coordinatingResponder?.setFavorite(team: team)
    }
    
    override func unsetFavorite(team: Team) {
        dependencies?.dataManager.unsetFavorite(team: team)
        
        // To make sure that the parent Coordinators will receive this message, we need to do this
        coordinatingResponder?.unsetFavorite(team: team)
    }
}
