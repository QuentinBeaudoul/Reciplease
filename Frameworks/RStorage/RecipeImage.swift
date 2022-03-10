//
//  RecipeImage.swift
//  RSearch
//
//  Created by Quentin on 07/03/2022.
//

import Foundation
import CoreData

public class RecipeImage: NSManagedObject, Decodable {

    enum CodingKeys: String, CodingKey {
        case url
        case width
        case height
    }

    public required convenience init(from decoder: Decoder) throws {

        self.init(context: StoreManager.shared.viewContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(String.self, forKey: .url)
        width = try container.decode(Int16.self, forKey: .width)
        height = try container.decode(Int16.self, forKey: .height)
    }
}
