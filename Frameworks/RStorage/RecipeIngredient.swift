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
        case food
        case measure
    }

    public required convenience init(from decoder: Decoder) throws {

        self.init(context: StoreManager.shared.viewContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        nameTitle = try container.decodeIfPresent(String.self, forKey: .nameTitle)
        quantity = try container.decodeIfPresent(Double.self, forKey: .quantity) ?? 0
        measure = try container.decodeIfPresent(String.self, forKey: .measure)
        food = try container.decodeIfPresent(String.self, forKey: .food)
    }
}

