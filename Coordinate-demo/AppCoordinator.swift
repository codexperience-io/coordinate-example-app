//
//  AppCoordinator.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit
import CoreData
import Coordinate

class AppCoordinator: ContainerCoordinator<AppViewController>, HasDependencies {
    
    var dependencies: AppDependencies?
  
    var activeRoute: Route = .splash
    
    // MARK: - Coordinator lifecycle
    
    override func start(with completion: @escaping () -> Void = {}) {

        // Do not use the direct self.dependencies = dependencies way, because this method does additional things
        self.setDependencies(dependencies:  AppDependencies())
        
        self.dependencies?.start { [weak self] in
            // Set the default screen first
            self?.goTo(.splash)
        }
        
        super.start(with: completion)
    }
    
    // MARK: - App Life Cycle
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.dependencies?.dataManager.save()
    }
    
    // MARK: - CoordinatingResponder
    
    override func splashDidFinish() {
        goTo(.mainNavigation)
    }
    
}

extension AppCoordinator: HasRoutes {
    // MARK: - Routing
    
    enum Route: Equatable {
        case splash
        case mainNavigation
    }
    
    func goTo(_ route: Route) {
        switch route {
        case .splash:
            self.showSplashScreen()
        case .mainNavigation:
            self.showMainNavigationScreen()
        }
        
        self.activeRoute = route
    }
    
    private func showSplashScreen() {
        let coordinator = getCached(SplashCoordinator.self) ?? SplashCoordinator()
        root(coordinator)
    }
    
    private func showMainNavigationScreen() {
        let coordinator = getCached(MainCoordinator.self) ?? MainCoordinator()
        root(coordinator)
    }
}
