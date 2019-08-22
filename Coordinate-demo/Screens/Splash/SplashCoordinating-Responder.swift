//
//  SplashCoordinating-Responder.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

extension UIResponder {
    
    @objc dynamic func splashDidFinish() {
        coordinatingResponder?.splashDidFinish()
    }
    
}
