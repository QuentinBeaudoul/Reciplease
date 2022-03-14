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

    func loadData(recipe: Recipe) {
        self.recipe = recipe
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

    func isFavorite() -> Bool {
        return recipe?.isFavorite ?? false
    }

    func dropRecipe() -> Bool {
        guard let recipe = recipe else {
            return false
        }
        recipe.isFavorite = false
        return StoreManager.shared.dropRecipe(recipe)
    }

    func addRecipe() -> Bool {
        guard let recipe = recipe else {
            return false
        }
        recipe.isFavorite = true
        return StoreManager.shared.saveRecipe(recipe)
    }
}
