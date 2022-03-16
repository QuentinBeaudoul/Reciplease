//
//  SearchManager.swift
//  RSearch
//
//  Created by Quentin on 03/03/2022.
//

import Foundation
import UIKit
import RExtension
import RNetwork

protocol SearchManagerProtocol {
    func fetchRecipes(search: RequestParams, completion: @escaping (Result<ResponseContainer?, Error>) -> Void)
    func fetchNextPage(withUrl url: String, completion: @escaping (Result<ResponseContainer?, Error>) -> Void)
}

public final class SearchManager: SearchManagerProtocol {

    public static let shared = SearchManager()

    private let networkManager: NetworkManagerProtocol

    private init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    public func getSearchViewController() -> UIViewController {

        let navController = UINavigationController.makeFromStoryboard("Search",
                                                                      withIdentifier: "SearchNavViewController",
                                                                      in: Bundle(for: Self.self))

        navController.tabBarItem = UITabBarItem(title: "",
                                                 image: UIImage(systemName: "magnifyingglass.circle"),
                                                 selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))

        return navController
    }

    func fetchRecipes(search: RequestParams, completion: @escaping (Result<ResponseContainer?, Error>) -> Void) {

        let url = Constantes.searchUrl
        let params = search.buildParameters()

        handleResult(url: url, params: params, completion: completion)
    }

    func fetchNextPage(withUrl url: String, completion: @escaping (Result<ResponseContainer?, Error>) -> Void) {
        handleResult(url: url, params: nil, completion: completion)
    }

    private func handleResult(url: String, params: [String: Any]?,
                              completion: @escaping (Result<ResponseContainer?, Error>) -> Void) {

        networkManager.fetchData(url: url, headers: nil, parameters: params, parser: ResponseContainer.self) { result in
            switch result {
            case .success(let container):
                if let container = container {
                    completion(.success(container))
                } else {
                    completion(.success(nil))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
