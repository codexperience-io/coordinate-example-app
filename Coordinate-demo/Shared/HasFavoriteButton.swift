//
//  HasFavoriteButton.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

@objc protocol HasFavoriteButtonObjC {
    @objc func favoriteButtonTapped(_ sender: UIButton)
}

protocol HasFavoriteButton: HasFavoriteButtonObjC {
    var favoriteButton: UIBarButtonItem? { get set }
    func configureFavoriteButton()
}

extension HasFavoriteButton where Self: UIViewController {
    
    func configureFavoriteButton() {
        if self.favoriteButton == nil {
            let favoriteButton = UIBarButtonItem(image: UIImage(named: "favorite-empty-icon"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
            self.navigationItem.setRightBarButtonItems([favoriteButton], animated: false)
            
            self.favoriteButton = favoriteButton
        }
    }
    
    func setFavoriteButtonIcon(_ isFavorite: Bool) {
        if isFavorite {
            self.favoriteButton?.image = UIImage(named: "favorite-full-icon")
        } else {
            self.favoriteButton?.image = UIImage(named: "favorite-empty-icon")
        }
    }
}
