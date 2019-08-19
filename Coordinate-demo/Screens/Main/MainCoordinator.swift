//
//  MainCoordinator.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit
import Coordinate

class MainCoordinator: TabBarCoordinator<MainViewController>, HasDependencies {
    
    var dependencies: AppDependencies?
    
    var activeRoute: Route = .teams(.list)
    
    // MARK: - Coordinator lifecycle
    
    override func start(with completion: @escaping () -> Void = {}) {
        super.start(with: completion)
        
        // Just as you would use UITabBarController.setControllers() to set the UIViewControllers and Tabs, only with Coordinators...
        self.setCoordinators([
            TeamsCoordinator(),
            DriversCoordinator(),
            ProfileCoordinator()
        ])
 
        self.goTo(activeRoute)
    }
        
    deinit {
    }
        
    override func activate() {
        super.activate()
        self.goTo(activeRoute)
    }
    
    // MARK: - Navigation
    
    /*
        Example override to intercept the calls to change Tabs
    */
    override func tabTapped(for coordinator: Coordinated) {
        
        // Use our "showScreen()" method so we can keep track of which Tab is selected, and do other things if we want
        switch coordinator {
        case is TeamsCoordinator:
            goTo(.teams(.list))
        case is DriversCoordinator:
            goTo(.drivers(.list))
        case is ProfileCoordinator:
            goTo(.profile)
        default:
            // do nothing
            return
        }
    }
    
    // MARK: - CoordinatingResponder
    
    override func setFavorite(team: Team) {
        self.updateProfileTabIcon()
    }
    
    override func unsetFavorite(team: Team) {
        self.updateProfileTabIcon()
    }
    
    override func setFavorite(driver: Driver) {
        self.updateProfileTabIcon()
    }
    
    override func unsetFavorite(driver: Driver) {
        self.updateProfileTabIcon()
    }
    
    override func didSelect(team: Team) {
        goTo(.teams(.team(team)))
    }
    
    override func didSelect(driver: Driver) {
        goTo(.drivers(.driver(driver)))
    }
}

extension MainCoordinator: HasRoutes {
    // MARK: - Routing
    
    enum Route: Equatable {
        case teams(TeamsCoordinator.Route?)
        case drivers(DriversCoordinator.Route?)
        case profile
    }
    
    func goTo(_ route: Route) {
        self.activeRoute = route
        
        switch self.activeRoute {
        case .teams(let subScreen):
            showTeamsScreen(subScreen)
        case .drivers(let subScreen):
            showDriversScreen(subScreen)
        case .profile:
            showProfileScreen()
        }
    }
    
    private func showTeamsScreen(_ subRoute: TeamsCoordinator.Route? = nil) {
        let coordinator = getCached(TeamsCoordinator.self) ?? TeamsCoordinator()
        if let subRoute = subRoute {
            coordinator.activeRoute = subRoute
        }
        self.select(coordinator)
    }
    
    private func showDriversScreen(_ subRoute: DriversCoordinator.Route? = nil) {
        let coordinator = getCached(DriversCoordinator.self) ?? DriversCoordinator()
        if let subRoute = subRoute {
            coordinator.activeRoute = subRoute
        }
        self.select(coordinator)
    }
    
    private func showProfileScreen() {
        let coordinator = getCached(ProfileCoordinator.self) ?? ProfileCoordinator()
        self.select(coordinator)
    }
}

private extension MainCoordinator {
    // MARK: - Internal
    
    func updateProfileTabIcon() {
        guard let (total, _, _) = dependencies?.dataManager.getProfileFavorites() else { return }
        
        var newValue: String?
        
        if total > 0 {
            newValue = String(total)
        }
        
        self.rootViewController.tabBar.items?[2].badgeValue = newValue
    }
}
