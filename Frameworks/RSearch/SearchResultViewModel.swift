//
//  SearchResultViewModel.swift
//  RSearch
//
//  Created by Quentin on 10/03/2022.
//

import Foundation
import RStorage

class SearchResultViewModel {

    private let searchManager: SearchManagerProtocol
    private let favoriteManager: FavoriteManagerProtocol

    private(set) var container: ResponseContainer?
    private(set) var recipes = [Recipe]()
    private(set) var displayFavorites: Bool = true

    init(searchManager: SearchManagerProtocol = SearchManager.shared,
         favoriteManager: FavoriteManagerProtocol = FavoriteManager.shared) {
        self.searchManager = searchManager
        self.favoriteManager = favoriteManager
    }

    /// Container = nil to display Favorites
    func loadData(container: ResponseContainer? = nil) {

        if let container = container, let recipes = container.recipes {
            self.container = container
            self.recipes = recipes
            self.displayFavorites = false
        } else {
            // Favorite stuff
            if let recipes = favoriteManager.favorites, displayFavorites {
                self.recipes = recipes
            }
        }
    }

    func reloadFavorite(completion: @escaping (Result<Bool, Error>) -> Void) {
        if displayFavorites {
            favoriteManager.loadFavorites { [self] result in

                switch result {

                case .success(let favoriteRecipes):
                    guard let favoriteRecipes = favoriteRecipes else {
                        return completion(.success(false))
                    }
                    recipes = favoriteRecipes
                    completion(.success(true))

                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    func fetchNextPage(completion: @escaping (Result<Void, Error>) -> Void) {

        searchManager.fetchNextPage(withUrl: getNextPage()) { result in
            switch result {

            case .success(let container):

                if let container = container, let recipes = container.recipes {
                    self.container = container
                    self.recipes.append(contentsOf: recipes)
                    completion(.success())
                }
            case .failure(let error):

                completion(.failure(error))
            }
        }
    }

    func hasNextPage() -> Bool {
        return container?.links?.nextPage != nil
    }

    func getNextPage() -> String {
        return container?.links?.nextPage ?? ""
    }

    func getNumberOfItems() -> Int {
        return recipes.count
    }

    func getRecipe(at indexPath: IndexPath) -> Recipe {
        return recipes[indexPath.row]
    }
}
