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
import CoreData

protocol FavoriteManagerProtocol {
    func loadFavorites(completion: (Result<[Recipe]?, Error>) -> Void)
    func saveRecipe() -> Bool
    func dropRecipe(recipeLabel: String?) -> Bool
    func isFavorite(recipeLabel: String?) -> Bool
    var favorites: [Recipe]? { get }
    var storeContext: NSManagedObjectContext { get }
}

public final class FavoriteManager: FavoriteManagerProtocol {

    public static let shared = FavoriteManager()

    private(set) var favorites: [Recipe]?
    private(set) var storeContext: NSManagedObjectContext

    private let manager: StoreManager

    init(manager: StoreManager = StoreManager.shared) {
        self.manager = manager
        storeContext = manager.context
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

    public func dropRecipe(recipeLabel: String?) -> Bool {
        return manager.dropRecipe(recipeLabel)
    }

    public func isFavorite(recipeLabel: String?) -> Bool {
        return manager.isFavorite(recipeLabel: recipeLabel)
    }
}
