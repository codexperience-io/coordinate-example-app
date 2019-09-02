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

    func getFavorites() -> ([Team], [Driver]) {
        var teams = [Team]()
        var drivers = [Driver]()

        if let favoriteTeams = self.favorite_teams?.allObjects as? [Team] {
            teams = favoriteTeams
        }

        if let favoriteDrivers = self.favorite_drivers?.allObjects as? [Driver] {
            drivers = favoriteDrivers
        }

        return (teams, drivers)
    }
}
