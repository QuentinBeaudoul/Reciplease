//
//  SearchResultViewModel.swift
//  RSearch
//
//  Created by Quentin on 10/03/2022.
//

import Foundation

class SearchResultViewModel {

    private let manager: SearchManagerProtocol

    init(manager: SearchManagerProtocol = SearchManager.shared) {
        self.manager = manager
    }

    private(set) var container: ResponseContainer?

    func fetchRecipes(keywords: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let request = RequestParams(search: keywords)

        manager.fetchRecipes(search: request) { result in
            switch result {

            case .success(let container):

                if let container = container {
                    self.container = container
                    completion(.success())
                }
            case .failure(let error):

                completion(.failure(error))
            }
        }
    }

    func fetchNextPage(completion: @escaping (Result<Void, Error>) -> Void) {

        manager.fetchNextPage(withUrl: getNextPage()) { result in
            switch result {

            case .success(let container):

                if let container = container {
                    self.container = container
                    completion(.success())
                }
            case .failure(let error):

                completion(.failure(error))
            }
        }
    }

    func getNextPage() -> String {
        return container?.links?.nextPage ?? ""
    }
}
