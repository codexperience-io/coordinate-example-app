//
//  AppEvents.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import Coordinate

struct AppEvents {
    enum Splash: CoordinateEvents, Equatable {
        case didFinish
    }
    
    enum Teams: CoordinateEvents, Equatable {
        case setFavorite(_ team: Team)
        case unsetFavorite(_ team: Team)
        case didSelect(_ team: Team)
    }
    
    enum Drivers: CoordinateEvents, Equatable {
        case setFavorite(_ driver: Driver)
        case unsetFavorite(_ driver: Driver)
        case didSelect(_ driver: Driver)
    }
}
