//
//  SearchViewModel.swift
//  RSearch
//
//  Created by Quentin on 03/03/2022.
//

import Foundation
import RStorage

class SearchViewModel {

    private(set) var keywords = [String]()

    func removeAll() {
        keywords.removeAll()
    }

    func remove(at indexPath: IndexPath) {
        keywords.remove(at: indexPath.row)
    }

    func add(newElement element: String) {
        keywords.append(element)
    }

    func getKeyword(at indexPath: IndexPath) -> String {
        return keywords[indexPath.row]
    }

    func getNumberOfItems() -> Int {
        return keywords.count
    }

    func isKeywordValid(_ keyword: String) -> Bool {
        return keyword.range(of: ".*[^A-Za-z0-9].*", options: .regularExpression) == nil
    }
}
