//
//  RecipeContainer.swift
//  RSearch
//
//  Created by Quentin on 07/03/2022.
//

import Foundation

class ResponseContainer: Decodable {
    let from: Int
    let to: Int
    let count: Int
    let links: ResponseLinks?
    let recipes: [RecipeContainer]?

    enum CodingKeys: String, CodingKey {
        case from
        case to
        case count
        case links = "_links"
        case recipes = "hits"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        from = try container.decode(Int.self, forKey: .from)
        to = try container.decode(Int.self, forKey: .to)
        count = try container.decode(Int.self, forKey: .count)
        links = try container.decodeIfPresent(ResponseLinks.self, forKey: .links)
        recipes = try container.decodeIfPresent([RecipeContainer].self, forKey: .recipes)
    }

}
