//
//  ProfileViewController.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var profile: Profile? {
        didSet {
            if isViewLoaded {
                self.configure()
            }
        }
    }
    
    private var favoritesListViewController: FavoritesListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addFavoritesList()
        self.configure()
    }
    
    // MARK: - Private
    
    private func addFavoritesList() {
        let viewController = FavoritesListViewController.instantiateFromStoryboard()
        
        // Add new ViewController
        addChild(viewController)
        view.insertSubview(viewController.view, at: 0)
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        viewController.didMove(toParent: self)
        
        self.favoritesListViewController = viewController
    }
    
    private func configure() {
        title = "Profile"
        
        nameLabel.text = profile?.name
        
        favoritesListViewController?.configure(with: profile)
    }
    
}
