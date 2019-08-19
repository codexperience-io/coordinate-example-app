//
//  Main-CoordinatingResponder.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

extension UIResponder {
 
    @objc dynamic func didSelect(team: Team) {
        coordinatingResponder?.didSelect(team: team)
    }
    
    @objc dynamic func didSelect(driver: Driver) {
        coordinatingResponder?.didSelect(driver: driver)
    }
    
    @objc dynamic func setFavorite(team: Team) {
        coordinatingResponder?.setFavorite(team: team)
    }
    
    @objc dynamic func unsetFavorite(team: Team) {
        coordinatingResponder?.unsetFavorite(team: team)
    }
    
    @objc dynamic func setFavorite(driver: Driver) {
        coordinatingResponder?.setFavorite(driver: driver)
    }
    
    @objc dynamic func unsetFavorite(driver: Driver) {
        coordinatingResponder?.unsetFavorite(driver: driver)
    }
}
