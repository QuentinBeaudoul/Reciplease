//
//  FavoriteManager.swift
//  RSearch
//
//  Created by Quentin on 16/03/2022.
//

import Foundation
import UIKit
import RExtension
import RStorage

public final class FavoriteManager: StoreProtocol {

    public static let shared = FavoriteManager()

    private(set) var favorites: [Recipe]?

    private let manager: StoreProtocol

    init(manager: StoreProtocol = StoreManager.shared) {
        self.manager = manager
    }

    public func getFavoriteViewController() -> UIViewController {
        let navController = UINavigationController.makeFromStoryboard("SearchResult",
                                                                      withIdentifier: "FavoriteNavViewController",
                                                                      in: Bundle(for: Self.self))

        navController.tabBarItem = UITabBarItem(title: "",
                                                image: UIImage(systemName: "star.circle"),
                                                selectedImage: UIImage(systemName: "star.cicle.fill"))

        // preload data for favorites
        if let favoriteViewController = (navController as? UINavigationController)?.viewControllers.first as? SearchResultViewController {
            favoriteViewController.viewModel.loadData()
        }

        return navController
    }

    public func loadFavorites(completion: (Result<[Recipe]?, Error>) -> Void) {
        manager.loadFavorites { result in
            switch result {
            case .success(let recipes):
                favorites = recipes
                completion(.success(recipes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func saveRecipe(_ recipe: Recipe) -> Bool {
        return manager.saveRecipe(recipe)
    }

    public func dropRecipe(_ recipe: Recipe) -> Bool {
        return manager.dropRecipe(recipe)
    }

    public func isFavorite(recipe: Recipe?) -> Bool {
        return manager.isFavorite(recipe: recipe)
    }
}
