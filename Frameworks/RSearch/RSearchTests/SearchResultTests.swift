//
//  SearchResultTests.swift
//  RSearchTests
//
//  Created by Quentin on 17/03/2022.
//

import XCTest

@testable import RSearch

class SearchResultTests: XCTestCase {

    var viewModel: SearchResultViewModel?

    var container: ResponseContainer?

    override func setUp() {
        super.setUp()
        viewModel = SearchResultViewModel(searchManager: SearchManager(networkManager: StubNetworkManager()),
                                          favoriteManager: FavoriteManager(manager: StubCoreDataService()))

        container = Bundle.decode(ResponseContainer.self,
                                  from: "ResponseContainer.json",
                                  in: Bundle(for: Self.self))
    }

    func testGivenNoData_WhenLoadingDataFromContainer_ThenDataMustBeLoaded() {

        // When
        viewModel?.loadData(container: container)

        // Then
        XCTAssertNotNil(viewModel?.recipes)
    }

    func testGivenNoData_WhenLoadingDataFromStorage_ThenDataMustBeLoaded() {

        // Given

        // When
        viewModel?.loadData()

        // Then

        XCTAssertNotNil(viewModel?.recipes)
    }

    func testGivenWantToFetchNextPage_WhenFetchingNextPage_ThenNewDataIsHappened() {

        // Given
        viewModel?.loadData(container: container)
        let countBeforeFetchNewPage = viewModel?.getNumberOfItems()
        // When

        viewModel?.fetchNextPage(completion: { [self] result in
            switch result {

            case .success():
                let countAfterFetchNewPage = viewModel?.getNumberOfItems()

                // Then
                XCTAssertEqual(countBeforeFetchNewPage, 20)
                XCTAssertEqual(countAfterFetchNewPage, 40)
            case .failure(_):
                break
            }
        })
    }

    func testGivenCurrentContainer_WhenCheckingIfThereIsANextPage_ThenHasANextPage() {

        // Given
        viewModel?.loadData(container: container)

        // When
        let mustBeTrue = viewModel?.hasNextPage()

        // Then

        XCTAssertTrue(mustBeTrue ?? false)
    }

    func testGivenCurrentContainer_WhenGettingNextPage_ThenGetNextPageUrl() {

        // Given
        viewModel?.loadData(container: container)

        // When
        let nextPage = viewModel?.getNextPage()

        // Then
        XCTAssertNotEqual(nextPage, "")
    }

    func testGivenCurrentContainer_WhenGettingRecipeAtIndexPath() {

        // Given
        viewModel?.loadData(container: container)

        // When
        let recipe = viewModel?.getRecipe(at: IndexPath(row: 0, section: 0))

        // Then
        XCTAssertNotNil(recipe)
        XCTAssertEqual(recipe?.label ?? "", "Smoked Trout and Egg Scramble Recipe")
    }
}
