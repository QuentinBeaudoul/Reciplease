//
//  SplashViewController.swift
//  Reciplease
//
//  Created by Quentin on 03/03/2022.
//

import UIKit
import RExtension

class SplashViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        imageView.image = R.image.icone(compatibleWith: traitCollection)

        // TODO: Faire le chargement des favoris présent en mémoire ici

        // TODO: Supprimer ça
        let seconds = 4.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
            let mainVC = MainTabbarController.makeFromStoryboard("Main")
            mainVC.modalPresentationStyle = .overFullScreen
            self.present(mainVC, animated: true)
        }
    }

}
