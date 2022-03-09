//
//  Recipe.swift
//  RSearch
//
//  Created by Quentin on 07/03/2022.
//

import Foundation

class Recipe: Decodable {
    let label: String
    let imageUrl: String?
    let images: RecipeImageContainer
    let ingredients: [RecipeIngredient]
    let totalTime: Double

    enum CodingKeys: String, CodingKey {
        case label
        case imageUrl = "image"
        case images
        case ingredients
        case totalTime
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        label = try container.decode(String.self, forKey: .label)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        images = try container.decode(RecipeImageContainer.self, forKey: .images)
        ingredients = try container.decode([RecipeIngredient].self, forKey: .ingredients)
        totalTime = try container.decode(Double.self, forKey: .totalTime)
    }
}
