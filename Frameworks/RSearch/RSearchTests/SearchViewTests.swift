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

    override func setUp() {
        super.setUp()
        viewModel.setKeywords(["Salad", "Egg", "Meat"])
    }

    func testGivenEmptyKeywordsArray_WhenFillingArray_ThenTheArrayIsFilled() {
        // Given setUp
        // When setUp
        // Then
        XCTAssertEqual(viewModel.getNumberOfItems(), 3)
        XCTAssertEqual(viewModel.keywords, ["Salad", "Egg", "Meat"])
    }

    func testGivenKeywords_WhenDeletingAllKeywords_ThenArrayMustBeEmpty() {
        // Given setUp()

        // When
        viewModel.removeAll()

        // Then
        XCTAssertTrue(viewModel.keywords.isEmpty)
    }

    func testGivenKeywords_WhenDeletingAtIndexPath_ThenItemIsDeleted() {
        // Given setUp()

        // When
        viewModel.remove(at: IndexPath(row: 1, section: 0))

        // Then
        XCTAssertEqual(viewModel.keywords, ["Salad", "Meat"])
    }

    func testGivenKeywords_WhenAddingANewElement_ThenElementIsAdded() {
        // Given setUp

        // When
        viewModel.add(newElement: "Cheese")

        // Then
        XCTAssertEqual(viewModel.keywords, ["Salad", "Egg", "Meat", "Cheese"])
    }

    func testGivenKeywords_WhenGettingKeywordAtIndex_ThenKeywordMustBeGet() {
        // Given setUp

        // When
        let element = viewModel.getKeyword(at: IndexPath(row: 2, section: 0))

        // Then
        XCTAssertEqual(element, "Meat")
    }

    func testGivenKeywords_WhenGettingFormattedKeywords_ThenKeywordsMustBeGetFormatted() {
        // Given setUp()

        // When
        let formattedKeywords = viewModel.getKeywordsFormatted()

        // Then
        XCTAssertEqual(formattedKeywords, "Salad, Egg, Meat")
    }

    func testGivenKeyword_WhenCheckingWordValidity_ThenKeywordMustBeValidatedProperly() {
        // Given setUp()

        // When
        let notValid = viewModel.isKeywordValid("à\"é'ç&&è 🙃")
        let valid = viewModel.isKeywordValid("Yes")

        // Then
        XCTAssertTrue(valid)
        XCTAssertFalse(notValid)
    }

    func testGivenKeywords_WhenFetchingRecipes_ThenContainerMustBeParsedProperly() {
        // Given setUp()

        // When
        viewModel.fetchRecipes(keywords: "dummy") { result in
            switch result {
            case .success(let container):
                // Then
                XCTAssertNotNil(container)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
}
