//
//  DriversCoordinator.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit
import Coordinate

class DriversCoordinator: NavigationCoordinator<DriversNavigationViewController>, HasDependencies {
    
    var dependencies: AppDependencies?
    
    enum Route: Equatable {
        case list
        case team(_ team: Team)
        case driver(_ driver: Driver)
    }
    
    var activeRoute: Route = .list
    
    override init() {
        super.init()
        rootViewController.tabBarItem = UITabBarItem(title: "Drivers", image: UIImage(named: "helmet-icon"), tag: 1)
    }
    
    // MARK: - Coordinator lifecycle
    
    override func start(with completion: @escaping () -> Void = {}) {
        super.start(with: completion)
        self.goTo(activeRoute)
    }
    
    override func activate() {
        super.activate()
        self.goTo(activeRoute)
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
        if case .didSelect(let team) = event {
            self.goTo(.team(team))
            return true
        }
        return false
    }
    
    private func interceptEvent(_ event: AppEvents.Drivers) -> Bool {
        if case .didSelect(let driver) = event {
            self.goTo(.driver(driver))
            return true
        }
        return false
    }
}

extension DriversCoordinator: HasRoutes {
    // MARK: - Routing
    
    func goTo(_ route: Route) {
        switch route {
        case .list:
            self.showListScreen()
        case .team(let team):
            self.showTeamScreen(team)
        case .driver(let driver):
            self.showDriverScreen(driver)
        }
        
        self.activeRoute = route
    }
    
    private func showListScreen() {
        let coordinator = getCached(DriversListCoordinator.self) ?? DriversListCoordinator()
        coordinator.dependencies = dependencies
        self.root(coordinator, animated: true)
    }
    
    private func showTeamScreen(_ team: Team) {
        let coordinator = getCached(TeamsDetailsCoordinator.self) ?? TeamsDetailsCoordinator()
        coordinator.dependencies = dependencies
        coordinator.team = team
        self.show(coordinator, sender: self)
    }
    
    private func showDriverScreen(_ driver: Driver) {
        let coordinator = getCached(DriversDetailsCoordinator.self) ?? DriversDetailsCoordinator()
        coordinator.dependencies = dependencies
        coordinator.driver = driver
        self.show(coordinator, sender: self)
    }
}
