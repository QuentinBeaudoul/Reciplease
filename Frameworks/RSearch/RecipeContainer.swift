//
//  RecipeContainer.swift
//  RSearch
//
//  Created by Quentin on 07/03/2022.
//

import Foundation

class RecipeContainer: Decodable {
    let recipe: Recipe?

    enum CodingKeys: String, CodingKey {
        case recipe
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        recipe = try container.decodeIfPresent(Recipe.self, forKey: .recipe)
    }
}
