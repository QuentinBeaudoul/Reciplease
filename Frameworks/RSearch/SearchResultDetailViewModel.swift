//
//  SearchResultDetailViewModel.swift
//  RSearch
//
//  Created by Quentin on 10/03/2022.
//

import Foundation
import RStorage

class SearchResultDetailViewModel {

    private(set) var recipe: Recipe?

    func loadData(recipe: Recipe) {
        self.recipe = recipe
    }

    func getTitle() -> String {
        return recipe?.label ?? ""
    }
}
