//
//  SplashViewController.swift
//  Coordinate-demo
//
//  Copyright © 2019 codexperience.io · https://codexperience.io
//  Website and Docs · https://coordinate.codexperience.io
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var coordinateLogoImage: UIImageView!
    @IBOutlet var labels: [UILabel]!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.9,
                       delay: 0,
                       options: [],
                       animations: { [weak self] in
                        
                        self?.titleImage.alpha = 1
                        self?.coordinateLogoImage.alpha = 1
                        self?.labels.forEach({ label in
                            label.alpha = 1
                        })
                        
            }, completion: { [weak self] _ in
                //Lets give it a second so its not too fast...
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self?.splashDidFinish()
                }
        })
    }
}
