//
//  TeamsDetailsViewController.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

class TeamsDetailsViewController: UIViewController, HasFavoriteButton {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var driver1Button: UIButton!
    @IBOutlet weak var driver2Button: UIButton!
    
    @IBAction func driver1ButtonDidTouch(_ sender: Any) {
        if let driver = self.sortedDrivers.first {
            didSelect(driver: driver)
        }
    }
    
    @IBAction func driver2ButtonDidTouch(_ sender: Any) {
        if let driver = self.sortedDrivers.last {
            didSelect(driver: driver)
        }
    }
    
    var favoriteButton: UIBarButtonItem?
    
    /*
     This UIViewController is intended to be re-utilized from cache after the first initialization,
     therefore you need to make sure that the UI reflects the latest data
     */
    var team: Team? {
        didSet {
            if let drivers = self.team?.drivers?.allObjects as? [Driver] {
                self.sortedDrivers = drivers.sorted(by: { lhs, rhs in
                    if let lhsName = lhs.name, let rhsName = rhs.name {
                        return lhsName < rhsName
                    } else {
                        return false
                    }
                })
            }
            
            if isViewLoaded {
                self.configure()
            }
        }
    }
    
    private var sortedDrivers = [Driver]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    private func configure() {
        title = team?.name
        nameLabel.text = team?.name

        driver1Button.setTitle(self.sortedDrivers.first?.name, for: .normal)
        driver2Button.setTitle(self.sortedDrivers.last?.name, for: .normal)
        
        self.configureFavoriteButton()
        
        if let team = team, team.isFavorite() {
            setFavoriteButtonIcon(true)
        } else {
            setFavoriteButtonIcon(false)
        }
    }
    
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        guard let team = self.team else { return }
        
        if team.isFavorite() {
            unsetFavorite(team: team)
            setFavoriteButtonIcon(false)
        } else {
            setFavorite(team: team)
            setFavoriteButtonIcon(true)
        }
    }
}
