//
//  RecipeImageContainer.swift
//  RSearch
//
//  Created by Quentin on 07/03/2022.
//

import Foundation
import RStorage

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

    func toCDRecipeImageContainer() -> CDRecipeImageContainer {
        let cdRecipeImageContainer = CDRecipeImageContainer(context: StoreManager.shared.context)

        cdRecipeImageContainer.thumbnail = thumbnail?.toCDRecipeImage()
        cdRecipeImageContainer.small = small?.toCDRecipeImage()
        cdRecipeImageContainer.regular = regular?.toCDRecipeImage()
        cdRecipeImageContainer.large = large?.toCDRecipeImage()

        return cdRecipeImageContainer
    }
}
