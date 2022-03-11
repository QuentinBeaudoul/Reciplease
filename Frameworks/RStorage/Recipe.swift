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
        label = try recipeContainer.decode(String.self, forKey: .label)
        imageUrl = try recipeContainer.decodeIfPresent(String.self, forKey: .imageUrl)
        images = try recipeContainer.decode(RecipeImageContainer.self, forKey: .images)
        ingredients = try recipeContainer.decode([RecipeIngredient].self, forKey: .ingredients)
        totalTime = try recipeContainer.decode(Double.self, forKey: .totalTime)
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
        guard let ingredients = ingredients else {
            return ""
        }
        return ingredients.map { ingre in
            ingre.nameTitle ?? ""
        }.formatted()
    }

    public func getTimeToDo() -> String {
        return "\(Int(totalTime))m"
    }
}
