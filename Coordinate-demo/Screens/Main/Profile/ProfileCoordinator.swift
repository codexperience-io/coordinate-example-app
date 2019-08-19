//
//  ProfileCoordinator.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit
import Coordinate

class ProfileCoordinator: Coordinator<ProfileViewController>, HasDependencies {
    
    var dependencies: AppDependencies?
    
    override init() {
        super.init()
        rootViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "user-icon"), tag: 2)
    }
    
    override func start(with completion: @escaping () -> Void = {}) {
        super.start(with: completion)
        
        rootViewController.profile = dependencies?.dataManager.getProfile()
    }
    
    override func activate() {
        super.activate()
        // Refresh profile object everytime we come to this page
        rootViewController.profile = dependencies?.dataManager.getProfile()
    }
    
    // MARK: - CoordinatingResponder
    
    override func unsetFavorite(team: Team) {
        dependencies?.dataManager.unsetFavorite(team: team)
        
        rootViewController.profile = dependencies?.dataManager.getProfile()
        
        // Keep the event bubbling up
        coordinatingResponder?.unsetFavorite(team: team)
    }
    
    override func unsetFavorite(driver: Driver) {
        dependencies?.dataManager.unsetFavorite(driver: driver)
        
        rootViewController.profile = dependencies?.dataManager.getProfile()
        
        // Keep the event bubbling up
        coordinatingResponder?.unsetFavorite(driver: driver)
    }
}
