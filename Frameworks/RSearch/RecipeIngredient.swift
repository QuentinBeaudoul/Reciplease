//
//  RecipeIngredient.swift
//  RStorage
//
//  Created by Quentin on 09/03/2022.
//

import Foundation
import RStorage
import CoreData

public class RecipeIngredient: Decodable {

    let nameTitle: String?
    let quantity: Double
    let measure: String?
    let food: String?

    enum CodingKeys: String, CodingKey {
        case nameTitle = "text"
        case quantity
        case food
        case measure
    }

    init(cdRecipeIngredient: CDRecipeIngredient) {
        nameTitle = cdRecipeIngredient.nameTitle
        quantity = cdRecipeIngredient.quantity
        food = cdRecipeIngredient.food
        measure = cdRecipeIngredient.measure
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        nameTitle = try container.decodeIfPresent(String.self, forKey: .nameTitle)
        quantity = try container.decodeIfPresent(Double.self, forKey: .quantity) ?? 0
        measure = try container.decodeIfPresent(String.self, forKey: .measure)
        food = try container.decodeIfPresent(String.self, forKey: .food)
    }

    func toCDRecipeIngredient(context: NSManagedObjectContext) -> CDRecipeIngredient {
        let cdRecipeIngredient = CDRecipeIngredient(context: context)

        cdRecipeIngredient.nameTitle = nameTitle
        cdRecipeIngredient.quantity = quantity
        cdRecipeIngredient.measure = measure
        cdRecipeIngredient.food = food

        return cdRecipeIngredient
    }
}
