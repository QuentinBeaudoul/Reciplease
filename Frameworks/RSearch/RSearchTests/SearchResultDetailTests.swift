//
//  SearchResultDetailTests.swift
//  RSearchTests
//
//  Created by Quentin on 17/03/2022.
//

import XCTest

@testable import RSearch

class SearchResultDetailTests: XCTestCase {

    let viewModel = SearchResultDetailViewModel(favManager: FavoriteManager(manager: StubStoreManager()))
}
