//
//  DriversListCoordinator.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit
import Coordinate

class DriversListCoordinator: Coordinator<DriversListViewController>, HasDependencies {
        
    var dependencies: AppDependencies?
    
    override func start(with completion: @escaping () -> Void = {}) {
        super.start(with: completion)
        self.refreshData()
    }
    
    override func activate() {
        super.activate()
        self.refreshData()
    }
    
    private func refreshData() {
        rootViewController.data = self.dependencies?.dataManager.getDrivers() ?? [Driver]()
    }
}
