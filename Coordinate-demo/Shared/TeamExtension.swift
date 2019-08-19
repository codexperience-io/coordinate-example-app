//
//  TeamExtension.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

// Convenience methods for automatically generated Team class
extension Team {
    
    public func isFavorite() -> Bool {
        var isFavorite = false
        
        if let count = self.favorite_in_profiles?.allObjects.count, count > 0 {
            isFavorite = true
        }
        
        return isFavorite
    }
}
