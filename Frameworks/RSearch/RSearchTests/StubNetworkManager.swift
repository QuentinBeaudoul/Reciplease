//
//  StubNetworkManager.swift
//  RSearchTests
//
//  Created by Quentin on 17/03/2022.
//

import Foundation
import RNetwork
@testable import RSearch

class StubNetworkManager: NetworkManagerProtocol {

    func fetchData<T>(url: String,
                      headers: [String: String]?,
                      parameters: [String: Any]?,
                      parser: T.Type,
                      completion: @escaping (Result<T?, Error>) -> Void) where T: Decodable {

        if let container = Bundle.decode(ResponseContainer.self,
                                         from: "ResponseContainer.json",
                                         in: Bundle(for: Self.self)) as? T {
            completion(.success(container))
            return
        }

        completion(.success(nil))
    }
}
