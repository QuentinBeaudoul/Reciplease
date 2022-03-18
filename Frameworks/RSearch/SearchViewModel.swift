//
//  SearchViewModel.swift
//  RSearch
//
//  Created by Quentin on 03/03/2022.
//

import Foundation
import RStorage
import RNetwork

class SearchViewModel {

    private(set) var keywords = [String]()
    private let manager: SearchManagerProtocol

    init(manager: SearchManagerProtocol = SearchManager.shared) {
        self.manager = manager
    }

    /// For tests use only
    func setKeywords(_ keywords: [String]) {
        self.keywords = keywords
    }

    func removeAll() {
        keywords.removeAll()
    }

    func remove(at indexPath: IndexPath) {
        keywords.remove(at: indexPath.row)
    }

    func add(newElement element: String) {
        keywords.append(element)
    }

    func getKeyword(at indexPath: IndexPath) -> String {
        return keywords[indexPath.row]
    }

    func getKeywordsFormatted() -> String {
        return keywords.joined(separator: ", ")
    }

    func getNumberOfItems() -> Int {
        return keywords.count
    }

    func isKeywordValid(_ keyword: String) -> Bool {
        return keyword.range(of: ".*[^A-Za-z0-9\\s].*", options: .regularExpression) == nil
    }

    func fetchRecipes(keywords: String, completion: @escaping (Result<ResponseContainer, Error>) -> Void) {
        let request = RequestParams(search: keywords)

        manager.fetchRecipes(search: request) { result in
            switch result {

            case .success(let container):

                if let container = container {
                    completion(.success(container))
                }
            case .failure(let error):

                completion(.failure(error))
            }
        }
    }
}
