//
//  RecipeImageContainer.swift
//  RSearch
//
//  Created by Quentin on 07/03/2022.
//

import Foundation
import CoreData

public class RecipeImageContainer: NSManagedObject, Decodable {

    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
        case large = "LARGE"
    }

    public required convenience init(from decoder: Decoder) throws {

        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        thumbnail = try container.decodeIfPresent(RecipeImage.self, forKey: .thumbnail)
        small = try container.decodeIfPresent(RecipeImage.self, forKey: .small)
        regular = try container.decodeIfPresent(RecipeImage.self, forKey: .regular)
        large = try container.decodeIfPresent(RecipeImage.self, forKey: .large)
    }
}
