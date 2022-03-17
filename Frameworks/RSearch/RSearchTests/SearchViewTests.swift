//
//  RSearchTests.swift
//  RSearchTests
//
//  Created by Quentin on 25/02/2022.
//

import XCTest
@testable import RSearch

class SearchViewTests: XCTestCase {

    let viewModel = SearchViewModel(manager: SearchManager(networkManager: StubNetworkManager()))
}
