//
//  RecipeImageContainer.swift
//  RSearch
//
//  Created by Quentin on 07/03/2022.
//

import Foundation
import RStorage
import CoreData

public class RecipeImageContainer: Decodable {

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

    init(cdRecipeImageContainer: CDRecipeImageContainer?) {
        thumbnail = RecipeImage(cdRecipeImage: cdRecipeImageContainer?.thumbnail)
        small = RecipeImage(cdRecipeImage: cdRecipeImageContainer?.small)
        regular = RecipeImage(cdRecipeImage: cdRecipeImageContainer?.regular)
        large = RecipeImage(cdRecipeImage: cdRecipeImageContainer?.large)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        thumbnail = try container.decodeIfPresent(RecipeImage.self, forKey: .thumbnail)
        small = try container.decodeIfPresent(RecipeImage.self, forKey: .small)
        regular = try container.decodeIfPresent(RecipeImage.self, forKey: .regular)
        large = try container.decodeIfPresent(RecipeImage.self, forKey: .large)
    }

    func toCDRecipeImageContainer(context: NSManagedObjectContext) -> CDRecipeImageContainer {
        let cdRecipeImageContainer = CDRecipeImageContainer(context: context)

        cdRecipeImageContainer.thumbnail = thumbnail?.toCDRecipeImage(context: context)
        cdRecipeImageContainer.small = small?.toCDRecipeImage(context: context)
        cdRecipeImageContainer.regular = regular?.toCDRecipeImage(context: context)
        cdRecipeImageContainer.large = large?.toCDRecipeImage(context: context)

        return cdRecipeImageContainer
    }
}
