//
//  Recipe.swift
//  RStorage
//
//  Created by Quentin on 07/03/2022.
//

import Foundation
import CoreData

public class Recipe: NSManagedObject, Decodable {

    enum CodingKeys: String, CodingKey {
        case label
        case imageUrl = "image"
        case images
        case ingredients
        case totalTime
    }

    public required convenience init(from decoder: Decoder) throws {

        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        label = try container.decode(String.self, forKey: .label)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        images = try container.decode(RecipeImageContainer.self, forKey: .images)
        ingredients = try container.decode([RecipeIngredient].self, forKey: .ingredients)
        totalTime = try container.decode(Double.self, forKey: .totalTime)
    }
}
