//
//  FavoritesListViewController.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit
import CoreData

class FavoritesListViewController: UITableViewController {
    
    private var list = [NSManagedObject]()
    
    private static let identifier = String(describing: FavoritesListViewController.self)
    
    static func instantiateFromStoryboard() -> FavoritesListViewController {
        return UIStoryboard(name: identifier, bundle: nil).instantiateViewController(withIdentifier: identifier) as! FavoritesListViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
    }
    
    // MARK: - Public Interface
    
    func configure(with profile: Profile?) {
        if let profile = profile {
            let (_, teams, drivers) = profile.getFavorites()
            
            list = teams + drivers
        } else {
            list = [NSManagedObject]()
        }
        
        tableView.reloadData()
    }
}

extension FavoritesListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        
        if list.indices.contains(indexPath.row) {
            let managedObject = list[indexPath.row]
            
            if let team = managedObject as? Team {
                cell.textLabel?.text = team.name
            } else if let driver = managedObject as? Driver {
                cell.textLabel?.text = driver.name
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if list.indices.contains(indexPath.row) {
                let managedObject = list[indexPath.row]
                
                if let team = managedObject as? Team {
                    unsetFavorite(team: team)
                } else if let driver = managedObject as? Driver {
                    unsetFavorite(driver: driver)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if list.indices.contains(indexPath.row) {
            let managedObject = list[indexPath.row]
            
            if let team = managedObject as? Team {
                didSelect(team: team)
            } else if let driver = managedObject as? Driver {
                didSelect(driver: driver)
            }
        }
    }
    
}
