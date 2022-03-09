//
//  RecipeContainer.swift
//  RSearch
//
//  Created by Quentin on 07/03/2022.
//

import Foundation

public class RecipeContainer: Decodable {
    let recipe: Recipe?
    private(set) var isVavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case recipe
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        recipe = try container.decodeIfPresent(Recipe.self, forKey: .recipe)
    }

    public func changeFavorite() {
        isVavorite = !isVavorite
    }
}
