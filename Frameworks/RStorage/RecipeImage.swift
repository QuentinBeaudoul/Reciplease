//
//  RecipeImage.swift
//  RSearch
//
//  Created by Quentin on 07/03/2022.
//

import Foundation

class RecipeImage: Decodable {
    let url: String
    let width: Int
    let height: Int

    enum CodingKeys: String, CodingKey {
        case url
        case width
        case height
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(String.self, forKey: .url)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
    }
}
