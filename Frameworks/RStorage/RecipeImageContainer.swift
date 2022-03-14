//
//  RecipeImageContainer.swift
//  RSearch
//
//  Created by Quentin on 07/03/2022.
//

import Foundation
import CoreData

public class RecipeImageContainer: NSManagedObject, Decodable, NSCoding {


    public func encode(with coder: NSCoder) {
        coder.encode(thumbnail, forKey: "thumbnail")
        coder.encode(small, forKey: "small")
        coder.encode(regular, forKey: "regular")
        coder.encode(large, forKey: "large")
    }

    public required convenience init?(coder: NSCoder) {

        self.init(context: StoreManager.shared.viewContext)

        self.thumbnail = coder.decodeObject(forKey: "thumbnail") as? RecipeImage
        self.small = coder.decodeObject(forKey: "small") as? RecipeImage
        self.regular = coder.decodeObject(forKey: "regular") as? RecipeImage
        self.large = coder.decodeObject(forKey: "large") as? RecipeImage
    }


    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
        case large = "LARGE"
    }

    public required convenience init(from decoder: Decoder) throws {

        self.init(context: StoreManager.shared.viewContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        thumbnail = try container.decodeIfPresent(RecipeImage.self, forKey: .thumbnail)
        small = try container.decodeIfPresent(RecipeImage.self, forKey: .small)
        regular = try container.decodeIfPresent(RecipeImage.self, forKey: .regular)
        large = try container.decodeIfPresent(RecipeImage.self, forKey: .large)
    }
}
