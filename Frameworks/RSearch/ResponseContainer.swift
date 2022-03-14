//
//  RecipeContainer.swift
//  RSearch
//
//  Created by Quentin on 07/03/2022.
//

import Foundation
import RStorage

class ResponseContainer: Decodable {
    let from: Int?
    let toRecipe: Int?
    let count: Int?
    let links: ResponseLinks?
    let recipes: [Recipe]?

    enum CodingKeys: String, CodingKey {
        case from
        case toRecipe = "to"
        case count
        case links = "_links"
        case recipes = "hits"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        from = try container.decodeIfPresent(Int.self, forKey: .from)
        toRecipe = try container.decodeIfPresent(Int.self, forKey: .toRecipe)
        count = try container.decodeIfPresent(Int.self, forKey: .count)
        links = try container.decodeIfPresent(ResponseLinks.self, forKey: .links)
        recipes = try container.decodeIfPresent([Recipe].self, forKey: .recipes)
    }

}
