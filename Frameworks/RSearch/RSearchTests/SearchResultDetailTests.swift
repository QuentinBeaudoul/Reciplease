//
//  SearchResultDetailTests.swift
//  RSearchTests
//
//  Created by Quentin on 17/03/2022.
//

import XCTest

@testable import RSearch

class SearchResultDetailTests: XCTestCase {

    let viewModel = SearchResultDetailViewModel(favManager: FavoriteManager(manager: StubCoreDataService()))

    var recipe: Recipe?

    override func setUp() {
        super.setUp()
        recipe = Bundle.decode(ResponseContainer.self,
                               from: "ResponseContainer.json",
                               in: Bundle(for: Self.self)).recipes?.first

        if let recipe = recipe {
            viewModel.loadData(recipe: recipe)
        }
    }

    func testGivenNilRecipe_WhenLoadingData_ThenRecipeMustBeSet() {
        // Given nothing

        // When setUp()

        // Then
        XCTAssertNotNil(viewModel.recipe)
    }

    func testGivenRecipe_WhenGettingRecipeTitle_ThenTitleMustBeGet() {
        // Given setUp()

        // When
        let title = viewModel.getTitle()

        // Then
        XCTAssertNotEqual(title, "")
    }

    func testGivenRecipe_WhenGettingNumberOfItems_ThenNumberOfItemsMustBeDifferentThanZero() {
        // Given setUp()

        // When
        let count = viewModel.getNumberOfItems()

        // Then
        XCTAssertNotEqual(count, 0)
    }

    func testGivenRecipe_WhenGettingIngredientAtIndexPath_ThenIngredientMustBeDifferenteThanZero() {
        // Given setUp()

        // When
        let ingredient = viewModel.getIngredient(at: IndexPath(row: 0, section: 0))

        // Then
        XCTAssertEqual(ingredient, "12 eggs, beaten")
    }

    func testGivenRecipe_WhenCheckingIfRecipeHasTimeToDo_ThenTimeToDoMustBeTrue() {
        // Given setUp()

        // When
        let timeToDo = viewModel.hasTimeToDo()

        // Then
        XCTAssertTrue(timeToDo)
    }

    func testGivenRecipe_WhenGettingTimeToDo_ThenTimeToDoMustNotBeEmpty() {
        // Given setUp()

        // When
        let timeToDo = viewModel.getTimeToDo()

        // Then
        XCTAssertEqual(timeToDo, "20m")
    }

    func testGivenRecipe_WhenGettingImageUrl_ThenGetImageUrl() {
        // Given setUp()

        // When
        let imageUrl = viewModel.getImageUrl()!

        XCTAssertNotEqual(imageUrl.absoluteString, "")
    }
}
