//
//  SearchResultTests.swift
//  RSearchTests
//
//  Created by Quentin on 17/03/2022.
//

import XCTest

@testable import RSearch

class SearchResultTests: XCTestCase {

    let viewModel = SearchResultViewModel(searchManager: SearchManager(networkManager: StubNetworkManager()),
                                          favoriteManager: FavoriteManager(manager: StubStoreManager()))
}
