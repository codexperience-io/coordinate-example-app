//
//  TeamsCoordinator.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit
import Coordinate

class TeamsCoordinator: NavigationCoordinator<TeamsNavigationViewController>, HasDependencies {
    
    var dependencies: AppDependencies?
    
    var activeRoute: Route = .list
    
    override init() {
        super.init()
        rootViewController.tabBarItem = UITabBarItem(title: "Teams", image: UIImage(named: "car-icon"), tag: 0)
    }
    
    override func start(with completion: @escaping () -> Void = {}) {
        super.start(with: completion)
        self.goTo(activeRoute)
    }
    
    override func activate() {
        super.activate()
        self.goTo(activeRoute)
    }
    
    // MARK: - CoordinatingResponder
    
    override func didSelect(team: Team) {
        self.goTo(.team(team))
    }
    
    override func didSelect(driver: Driver) {
        self.goTo(.driver(driver))
    }
}

extension TeamsCoordinator: HasRoutes {
    
    enum Route: Equatable {
        case list
        case team(_ team: Team)
        case driver(_ driver: Driver)
    }
    
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
        let coordinator = getCached(TeamsListCoordinator.self) ?? TeamsListCoordinator()
        self.root(coordinator)
    }
    
    private func showTeamScreen(_ team: Team) {
        let coordinator = getCached(TeamsDetailsCoordinator.self) ?? TeamsDetailsCoordinator()
        coordinator.team = team
        self.show(coordinator, sender: self)
    }
    
    private func showDriverScreen(_ driver: Driver) {
        let coordinator = getCached(DriversDetailsCoordinator.self) ?? DriversDetailsCoordinator()
        coordinator.driver = driver
        self.show(coordinator, sender: self)
    }
}
