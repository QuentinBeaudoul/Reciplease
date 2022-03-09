//
//  RecipeImageContainer.swift
//  RSearch
//
//  Created by Quentin on 07/03/2022.
//

import Foundation

class RecipeImageContainer: Decodable {
    let thumbnail: RecipeImage?
    let small: RecipeImage?
    let regular: RecipeImage?
    let large: RecipeImage?

    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
        case large = "LARGE"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        thumbnail = try container.decodeIfPresent(RecipeImage.self, forKey: .thumbnail)
        small = try container.decodeIfPresent(RecipeImage.self, forKey: .small)
        regular = try container.decodeIfPresent(RecipeImage.self, forKey: .regular)
        large = try container.decodeIfPresent(RecipeImage.self, forKey: .large)
    }
}
