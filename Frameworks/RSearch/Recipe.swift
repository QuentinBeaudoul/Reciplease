//
//  Recipe.swift
//  RStorage
//
//  Created by Quentin on 07/03/2022.
//

import Foundation
import RStorage

public class Recipe: Decodable {

    let label: String?
    let imageUrl: String?
    let images: RecipeImageContainer?
    let ingredients: [RecipeIngredient]?
    let totalTime: Double

    var isFavorite = false

    enum ContainerCodingKeys: String, CodingKey {
        case recipe
    }

    enum CodingKeys: String, CodingKey {
        case label
        case imageUrl = "image"
        case images
        case ingredients
        case totalTime
    }

    init(cdRecipe: CDRecipe) {
        label = cdRecipe.label
        imageUrl = cdRecipe.imageUrl
        images = RecipeImageContainer(cdRecipeImageContainer: cdRecipe.images)
        totalTime = cdRecipe.totalTime
        isFavorite = cdRecipe.isFavorite

        if let cdIngredients = cdRecipe.ingredients?.array as? [CDRecipeIngredient] {
            ingredients = cdIngredients.map({ cdRecipeIngredient in
                RecipeIngredient(cdRecipeIngredient: cdRecipeIngredient)
            })
        } else {
            ingredients = nil
        }
    }

    public required init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: ContainerCodingKeys.self)
        let recipeContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .recipe)
        label = try recipeContainer.decodeIfPresent(String.self, forKey: .label)
        imageUrl = try recipeContainer.decodeIfPresent(String.self, forKey: .imageUrl)
        images = try recipeContainer.decodeIfPresent(RecipeImageContainer.self, forKey: .images)
        ingredients = try recipeContainer.decodeIfPresent([RecipeIngredient].self, forKey: .ingredients)
        totalTime = try recipeContainer.decodeIfPresent(Double.self, forKey: .totalTime) ?? 0
    }

    public func getIngredientsFormatted() -> String {
        return ingredients?.compactMap { ingre in
            ingre.food
        }.compactMap({
            $0.capitalized
        }).joined(separator: ", ") ?? ""
    }

    public func getDetailIngredientsFormatted() -> [String]? {
        return ingredients?.compactMap { ingredient in
            ingredient.nameTitle
        }
    }

    public func getTimeToDo() -> String {
        return "\(Int(totalTime))m"
    }

    public func hasTimeToDo() -> Bool {
        return totalTime > 0
    }

    public func createCDRecipe() {
        let cdRecipe = CDRecipe(context: StoreManager.shared.context)

        cdRecipe.label = label
        cdRecipe.imageUrl = imageUrl
        cdRecipe.images = images?.toCDRecipeImageContainer()
        cdRecipe.isFavorite = isFavorite

        if let ingredients = ingredients {
            cdRecipe.ingredients = NSOrderedSet(array: ingredients.map({ recipeIngredient in
                recipeIngredient.toCDRecipeIngredient()
            }))
        }
        cdRecipe.totalTime = totalTime
    }

}
