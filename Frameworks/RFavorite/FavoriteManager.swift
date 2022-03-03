//
//  FavoriteManager.swift
//  RFavorite
//
//  Created by Quentin on 03/03/2022.
//

import Foundation
import UIKit
import RExtension

public final class FavoriteManager {
    public static let shared = FavoriteManager()
    private init() {}
    
    public func getViewController() -> UIViewController {
        let viewController = FavoriteViewController.makeFromStoryboard(in: Bundle(for: Self.self))
        viewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "star.circle"), selectedImage: UIImage(systemName: "star.circle.fill"))
        return viewController
    }
}
