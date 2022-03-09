//
//  RecipeImage.swift
//  RSearch
//
//  Created by Quentin on 07/03/2022.
//

import Foundation
import CoreData

class RecipeImage: NSManagedObject, Decodable {

    enum CodingKeys: String, CodingKey {
        case url
        case width
        case height
    }

    required convenience init(from decoder: Decoder) throws {

        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(String.self, forKey: .url)
        width = try container.decode(Int16.self, forKey: .width)
        height = try container.decode(Int16.self, forKey: .height)
    }
}
