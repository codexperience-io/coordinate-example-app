//
//  DriverExtension.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

// Convenience methods for automatically generated Driver class
extension Driver {

    public func isFavorite() -> Bool {
        var isFavorite = false

        if self.favorite_in_profiles?.allObjects.isEmpty == false {
            isFavorite = true
        }

        return isFavorite
    }
}
