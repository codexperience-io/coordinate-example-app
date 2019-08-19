//
//  TeamsListViewController.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

class TeamsListViewController: UITableViewController {
    
    var data = [Team]() {
        didSet {
            if isViewLoaded {
                self.tableView.reloadData()
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        self.configure()
    }
    
    private func configure() {
        title = "Teams"
    }
}

extension TeamsListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if data.indices.contains(indexPath.row) {
            let team = data[indexPath.row]
            var labelTitle = team.name
            
            if let name = team.name, team.isFavorite() {
                labelTitle = name + " ⭐️"
            }
            
            cell.textLabel?.text = labelTitle
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if data.indices.contains(indexPath.row) {
            let team = data[indexPath.row]
            
            didSelect(team: team)
        }
    }
}
