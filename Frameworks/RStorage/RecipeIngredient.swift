//
//  RecipeIngredient.swift
//  RStorage
//
//  Created by Quentin on 09/03/2022.
//

import Foundation
import CoreData

public class RecipeIngredient: NSManagedObject, Decodable {

    enum CodingKeys: String, CodingKey {
        case nameTitle = "text"
        case quantity
        case measure
    }

    public required convenience init(from decoder: Decoder) throws {

        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        nameTitle = try container.decode(String.self, forKey: .nameTitle)
        quantity = try container.decode(Double.self, forKey: .quantity)
        measure = try container.decodeIfPresent(String.self, forKey: .measure)
    }
}

