//
//  RecipeImage.swift
//  RSearch
//
//  Created by Quentin on 07/03/2022.
//

import Foundation
import RStorage

public class RecipeImage: Decodable {

    let url: String?
    let width: Int16?
    let height: Int16?

    enum CodingKeys: String, CodingKey {
        case url
        case width
        case height
    }

    init(cdRecipeImage: CDRecipeImage?) {
        url = cdRecipeImage?.url
        width = cdRecipeImage?.width
        height = cdRecipeImage?.height
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        width = try container.decodeIfPresent(Int16.self, forKey: .width)
        height = try container.decodeIfPresent(Int16.self, forKey: .height)
    }

    func toCDRecipeImage() -> CDRecipeImage {
        let cdRecipeImage = CDRecipeImage(context: StoreManager.shared.viewContext)
        cdRecipeImage.url = url
        cdRecipeImage.width = width ?? 0
        cdRecipeImage.height = height ?? 0

        return cdRecipeImage
    }
}
