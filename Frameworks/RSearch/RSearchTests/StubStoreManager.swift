//
//  StubStoreManager.swift
//  RSearchTests
//
//  Created by Quentin on 17/03/2022.
//

import Foundation
import RStorage

class StubStoreManager: StoreProtocol {

    func saveRecipe() -> Bool {
        <#code#>
    }

    func dropRecipe(_ recipeLabel: String?) -> Bool {
        <#code#>
    }

    func loadFavorites(completion: (Result<[CDRecipe]?, Error>) -> Void) {
        <#code#>
    }

    func isFavorite(recipeLabel: String?) -> Bool {
        <#code#>
    }
}
