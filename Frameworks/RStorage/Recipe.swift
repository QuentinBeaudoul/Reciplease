//
//  Recipe.swift
//  RStorage
//
//  Created by Quentin on 07/03/2022.
//

import Foundation
import CoreData

public class Recipe: NSManagedObject, Decodable {

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

    public required convenience init(from decoder: Decoder) throws {

        self.init(context: StoreManager.shared.viewContext)

        let container = try decoder.container(keyedBy: ContainerCodingKeys.self)
        let recipeContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .recipe)
        label = try recipeContainer.decodeIfPresent(String.self, forKey: .label)
        imageUrl = try recipeContainer.decodeIfPresent(String.self, forKey: .imageUrl)
        images = try recipeContainer.decodeIfPresent(RecipeImageContainer.self, forKey: .images)

        if let ingredients = try recipeContainer.decodeIfPresent([RecipeIngredient].self, forKey: .ingredients) {
            self.ingredients = NSOrderedSet(array: ingredients)
        }

        totalTime = try recipeContainer.decodeIfPresent(Double.self, forKey: .totalTime) ?? 0
    }

    func copy(from recipe: Recipe) {
        self.label = recipe.label
        self.imageUrl = recipe.imageUrl
        self.images = recipe.images
        self.isFavorite = recipe.isFavorite
        self.ingredients = recipe.ingredients
        self.totalTime = recipe.totalTime
    }

    public func getIngredientsFormatted() -> String {
        return ingredients?.map { ingre in
            ingre.food?.capitalized ?? ""
        }.joined(separator: ", ") ?? ""
    }

    public func getDetailIngredientsFormatted() -> [String]? {
        return ingredients?.array.map { ingredient in
            ingredient.nameTitle ?? ""
        }
    }

    public func getTimeToDo() -> String {
        return "\(Int(totalTime))m"
    }

    public func hasTimeToDo() -> Bool {
        return totalTime > 0
    }
}
