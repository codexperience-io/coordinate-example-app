//
//  AppDependency.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import CoreData
import Coordinate

//    Dependency carrier through the app,
//    injected into every Coordinator

struct AppDependencies: AppDependenciesProtocol {
    
    let dataManager: DataManager
    
    init() {
        self.dataManager = DataManager()
    }
    
    func start(with completion: @escaping () -> Void = {}) {
        self.dataManager.start {
            completion()
        }
    }
}
