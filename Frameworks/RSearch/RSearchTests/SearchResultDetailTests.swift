//
//  SearchResultDetailTests.swift
//  RSearchTests
//
//  Created by Quentin on 17/03/2022.
//

import XCTest
import RStorage

@testable import RSearch

class SearchResultDetailTests: XCTestCase {

    var viewModel: SearchResultDetailViewModel?

    var recipe: Recipe?

    override func setUp() {
        super.setUp()
        recipe = Bundle.decode(ResponseContainer.self,
                               from: "ResponseContainer.json",
                               in: Bundle(for: Self.self)).recipes?.first

        viewModel = SearchResultDetailViewModel(favManager: FavoriteManager(manager: StoreManager(coreDataService: StubCoreDataService())))

        if let recipe = recipe {
            viewModel?.loadData(recipe: recipe)
        }
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGivenNilRecipe_WhenLoadingData_ThenRecipeMustBeSet() {
        // Given nothing

        // When setUp()

        // Then
        XCTAssertNotNil(viewModel?.recipe)
    }

    func testGivenRecipe_WhenGettingRecipeTitle_ThenTitleMustBeGet() {
        // Given setUp()

        // When
        let title = viewModel?.getTitle()

        // Then
        XCTAssertNotEqual(title, "")
    }

    func testGivenRecipe_WhenGettingNumberOfItems_ThenNumberOfItemsMustBeDifferentThanZero() {
        // Given setUp()

        // When
        let count = viewModel?.getNumberOfItems()

        // Then
        XCTAssertNotEqual(count, 0)
    }

    func testGivenRecipe_WhenGettingIngredientAtIndexPath_ThenIngredientMustBeDifferenteThanZero() {
        // Given setUp()

        // When
        let ingredient = viewModel?.getIngredient(at: IndexPath(row: 0, section: 0))

        // Then
        XCTAssertEqual(ingredient, "12 eggs, beaten")
    }

    func testGivenRecipe_WhenCheckingIfRecipeHasTimeToDo_ThenTimeToDoMustBeTrue() {
        // Given setUp()

        // When
        let timeToDo = viewModel?.hasTimeToDo() ?? false

        // Then
        XCTAssertTrue(timeToDo)
    }

    func testGivenRecipe_WhenGettingTimeToDo_ThenTimeToDoMustNotBeEmpty() {
        // Given setUp()

        // When
        let timeToDo = viewModel?.getTimeToDo()

        // Then
        XCTAssertEqual(timeToDo, "20m")
    }

    func testGivenRecipe_WhenGettingImageUrl_ThenGetImageUrl() {
        // Given setUp()

        // When
        let imageUrl = viewModel!.getImageUrl()!

        XCTAssertNotEqual(imageUrl.absoluteString, "")
    }

    func testGivenRecipe_WhenAddingItToDatabase_ThenRecipeIsFavorite() {

        // Given setUp()

            // When
            let result = viewModel!.addRecipe()

            // Then
            let isFavorite = viewModel!.isFavorite()
            XCTAssertTrue(result && isFavorite)
    }

    func testGivenRecipeInDatabase_WhenDropingRecipeFromDatabase_ThenRecipeShouldntBeInFavoriteAnymore() {

        var dropSuccess = false

            // Given setUp()
            let addSuccess = viewModel!.addRecipe()

            // When
            dropSuccess = viewModel!.dropRecipe()

            // then
            XCTAssertTrue(addSuccess)
            XCTAssertTrue(dropSuccess)
    }
}
