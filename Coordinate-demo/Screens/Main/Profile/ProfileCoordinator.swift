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
    
    // MARK: - Events
    
    override func interceptEvent(_ event: CoordinateEvents) -> Bool {
        if let event = event as? AppEvents.Teams {
            return interceptEvent(event)
        } else if let event = event as? AppEvents.Drivers {
            return interceptEvent(event)
        }
        
        return false
    }
    
    private func interceptEvent(_ event: AppEvents.Teams) -> Bool {
        if case .unsetFavorite(let team) = event {
            dependencies?.dataManager.unsetFavorite(team: team)
        }
        return false
    }
    
    private func interceptEvent(_ event: AppEvents.Drivers) -> Bool {
        if case .unsetFavorite(let driver) = event {
            dependencies?.dataManager.unsetFavorite(driver: driver)
        }
        return false
    }
}
