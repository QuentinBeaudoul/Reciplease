//
//  ViewController.swift
//  Reciplease
//
//  Created by Quentin on 25/02/2022.
//

import UIKit
import RSearch
import RFavorite

class MainTabbarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        delegate = self
        let searchVC = SearchManager.shared.getViewController()
        let favoriteVC = FavoriteManager.shared.getViewController()

        setViewControllers([searchVC, favoriteVC], animated: false)
    }
}
