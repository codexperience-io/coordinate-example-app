//
//  ProfileExtension.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

// Convenience methods for automatically generated Profile class
extension Profile {
    
    func getFavorites() -> (total: Int, [Team], [Driver]) {
        var total = 0
        var teams = [Team]()
        var drivers = [Driver]()
        
        if let favoriteTeams = self.favorite_teams?.allObjects as? [Team] {
            total += favoriteTeams.count
            teams = favoriteTeams
        }
        
        if let favoriteDrivers = self.favorite_drivers?.allObjects as? [Driver] {
            total += favoriteDrivers.count
            drivers = favoriteDrivers
        }
        
        return (total, teams, drivers)
    }
}
