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
    override func tabTapped(for coordinator: Coordinating) {

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

    // MARK: - Events

    override func interceptEvent(_ event: CoordinateEvents) -> Bool {

        if let event = event as? AppEvents.Teams {

            switch event {
            case .setFavorite,
                .unsetFavorite:
                self.updateProfileTabIcon()
                return true
            case .didSelect(let team):
                goTo(.teams(.team(team)))
                return true
            }

        } else if let event = event as? AppEvents.Drivers {

            switch event {
            case .setFavorite,
                 .unsetFavorite:
                self.updateProfileTabIcon()
                return true
            case .didSelect(let driver):
                goTo(.drivers(.driver(driver)))
                return true
            }

        }

        return false
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
        switch route {
        case .teams(let subScreen):
            showTeamsScreen(subScreen)
        case .drivers(let subScreen):
            showDriversScreen(subScreen)
        case .profile:
            showProfileScreen()
        }
        
        self.activeRoute = route
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
        guard let (teams, drivers) = dependencies?.dataManager.getProfileFavorites() else { return }
        
        let total = teams.count + drivers.count
        
        var newValue: String?
        
        if total > 0 {
            newValue = String(total)
        }
        
        self.rootViewController.tabBar.items?[2].badgeValue = newValue
    }
}
