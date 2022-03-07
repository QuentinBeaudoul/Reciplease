//
//  RecipeIngredient.swift
//  RSearch
//
//  Created by Quentin on 07/03/2022.
//

import Foundation

class RecipeIngredient: Decodable {
    let nameTitle: String
    let quantity: Double
    let measure: String?

    enum CodingKeys: String, CodingKey {
        case nameTitle = "text"
        case quantity
        case measure
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        nameTitle = try container.decode(String.self, forKey: .nameTitle)
        quantity = try container.decode(Double.self, forKey: .quantity)
        measure = try container.decodeIfPresent(String.self, forKey: .measure)
    }
}
