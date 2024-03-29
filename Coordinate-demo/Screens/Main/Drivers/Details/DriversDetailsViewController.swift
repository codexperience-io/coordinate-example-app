//
//  DriversDetailsViewController.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit
import Coordinate

class DriversDetailsViewController: UIViewController, HasFavoriteButton, Coordinated {
    var parentCoordinator: Coordinating?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamButton: UIButton!
    
    @IBAction func teamButtonDidTouch(_ sender: Any) {
        guard let team = self.driver?.team else {
            return
        }
        
        emitEvent(AppEvents.Teams.didSelect(team))
    }
    
    var favoriteButton: UIBarButtonItem?
    
    /*
     This UIViewController is intended to be re-utilized from cache after the first initialization,
     therefore you need to make sure that the UI reflects the latest data
    */
    var driver: Driver? {
        didSet {
            if isViewLoaded {
                self.configure()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    private func configure() {
        title = driver?.name
        nameLabel.text = driver?.name
        teamButton.setTitle(driver?.team?.name, for: .normal)
        
        self.configureFavoriteButton()
        
        if let driver = driver, driver.isFavorite() {
            setFavoriteButtonIcon(true)
        } else {
            setFavoriteButtonIcon(false)
        }
    }
    
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        guard let driver = self.driver else { return }
        
        if driver.isFavorite() {
            emitEvent(AppEvents.Drivers.unsetFavorite(driver))
            setFavoriteButtonIcon(false)
        } else {
            emitEvent(AppEvents.Drivers.setFavorite(driver))
            setFavoriteButtonIcon(true)
        }
    }
}
