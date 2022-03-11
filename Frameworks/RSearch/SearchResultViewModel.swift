//
//  SearchResultViewModel.swift
//  RSearch
//
//  Created by Quentin on 10/03/2022.
//

import Foundation
import RStorage

class SearchResultViewModel {

    private let manager: SearchManagerProtocol

    private(set) var container: ResponseContainer?
    private(set) var recipes = [Recipe]()
    private(set) var isFavorite: Bool = false

    init(manager: SearchManagerProtocol = SearchManager.shared) {
        self.manager = manager
    }

    func loadData(isFavorite: Bool = false, container: ResponseContainer? = nil, recipes: [Recipe]? = nil) {

        self.isFavorite = isFavorite

        if let container = container, let recipes = container.recipes, !isFavorite {
            self.container = container
            self.recipes = recipes
        }

        // Favorite stuff
        if let recipes = recipes, isFavorite {
            self.recipes = recipes
        }
    }

    func fetchNextPage(completion: @escaping (Result<Void, Error>) -> Void) {

        manager.fetchNextPage(withUrl: getNextPage()) { result in
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
