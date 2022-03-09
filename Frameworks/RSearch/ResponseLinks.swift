//
//  RecipeLinks.swift
//  RSearch
//
//  Created by Quentin on 07/03/2022.
//

import Foundation

class ResponseLinks: Decodable {
    let nextPage: String?

    enum CodingKeys: String, CodingKey {
        case next
    }

    enum UrlsKeys: String, CodingKey {
        case href
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
            .nestedContainer(keyedBy: UrlsKeys.self, forKey: .next)
        nextPage = try container.decodeIfPresent(String.self, forKey: .href)
    }
}
