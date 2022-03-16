//
//  SplashViewController.swift
//  Reciplease
//
//  Created by Quentin on 03/03/2022.
//

import UIKit
import RExtension
import RSearch

class SplashViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = R.image.icone(compatibleWith: traitCollection)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        FavoriteManager.shared.loadFavorites { result in
            switch result {
            case .success(_):
                let mainVC = MainTabbarController.makeFromStoryboard("Main")
                mainVC.modalPresentationStyle = .overFullScreen
                self.present(mainVC, animated: true)
            case .failure(_):
                UIAlertController.showAlert(title: "Failed to load favorites",
                                            message: "Something went wrong while loading favorites...",
                                            on: self)
            }
        }
    }
}
