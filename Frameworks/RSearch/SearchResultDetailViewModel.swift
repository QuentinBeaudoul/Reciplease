//
//  SearchResultDetailViewModel.swift
//  RSearch
//
//  Created by Quentin on 10/03/2022.
//

import Foundation
import RStorage
import RExtension

class SearchResultDetailViewModel {

    private(set) var recipe: Recipe?

    let favoriteManager: FavoriteManagerProtocol

    init(favManager: FavoriteManagerProtocol = FavoriteManager.shared) {
        favoriteManager = favManager
    }

    func loadData(recipe: Recipe) {
        self.recipe = recipe
    }

    func isFavorite() -> Bool {
        return favoriteManager.isFavorite(recipeLabel: recipe?.label)
    }

    func getTitle() -> String {
        return recipe?.label ?? ""
    }

    func getNumberOfItems() -> Int {
        return recipe?.getDetailIngredientsFormatted()?.count ?? 0
    }

    func getIngredient(at indexPath: IndexPath) -> String {
        return recipe?.getDetailIngredientsFormatted()?[indexPath.row] ?? ""
    }

    func hasTimeToDo() -> Bool {
        return recipe?.hasTimeToDo() == true
    }

    func getTimeToDo() -> String {
        return recipe?.getTimeToDo() ?? ""
    }

    func getImageUrl() -> URL? {
        return URL(string: recipe?.images?.regular?.url ?? recipe?.imageUrl ?? "")
    }

    func dropRecipe() -> Bool {
        guard let recipe = recipe, let label = recipe.label else {
            return false
        }

        return favoriteManager.dropRecipe(recipeLabel: label)
    }

    func addRecipe() -> Bool {
        guard let recipe = recipe else {
            return false
        }
        recipe.isFavorite = true

        recipe.createCDRecipe()

        return favoriteManager.saveRecipe()
    }
}
