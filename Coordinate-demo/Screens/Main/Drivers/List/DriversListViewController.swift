//
//  DriversListViewController.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

class DriversListViewController: UITableViewController {
    
    var data = [Driver]() {
        didSet {
            if isViewLoaded {
                self.tableView.reloadData()
            }
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        title = "Drivers"
        tableView.delegate = self
    }
}

extension DriversListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if data.indices.contains(indexPath.row) {
            let driver = data[indexPath.row]
            var labelTitle = driver.name
            
            if let name = driver.name, driver.isFavorite() {
                labelTitle = name + " ⭐️"
            }
            
            cell.textLabel?.text = labelTitle
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if data.indices.contains(indexPath.row) {
            let driver = data[indexPath.row]
            
            didSelect(driver: driver)
        }
    }
}
