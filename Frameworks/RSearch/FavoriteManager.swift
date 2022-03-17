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

public final class FavoriteManager {

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
        if let favoriteViewController =
            (navController as? UINavigationController)?.viewControllers.first as? SearchResultViewController {
            favoriteViewController.viewModel.loadData()
        }

        return navController
    }

    public func loadFavorites(completion: (Result<[Recipe]?, Error>) -> Void) {
        manager.loadFavorites { result in
            switch result {
            case .success(let recipes):
                favorites = recipes?.compactMap({ cdRecipe in
                    Recipe(cdRecipe: cdRecipe)
                })
                completion(.success(favorites))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func saveRecipe() -> Bool {
        return manager.saveRecipe()
    }

    public func dropRecipe(_ recipe: Recipe) -> Bool {
        return manager.dropRecipe(recipe.label)
    }

    public func isFavorite(recipeLabel: String?) -> Bool {
        return manager.isFavorite(recipeLabel: recipeLabel)
    }
}
