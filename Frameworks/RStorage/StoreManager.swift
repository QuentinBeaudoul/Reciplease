//
//  StoreManager.swift
//  RStorage
//
//  Created by Quentin on 09/03/2022.
//

import Foundation
import CoreData

public final class StoreManager {
    public static let shared = StoreManager()

    public let context: NSManagedObjectContext

    public init(coreDataService: CoreDataServiceProtocol = CoreDataService.shared) {
        self.context = coreDataService.context
    }

    public func saveRecipe() -> Bool {

        do {
            try context.save()
            return true
        } catch let error {
            print(error)
            return false
        }
    }

    public func dropRecipe(_ recipeLabel: String?) -> Bool {
        guard let recipeLabel = recipeLabel else { return false }

        let request = CDRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "label LIKE %@", recipeLabel)

        do {

            if let recipeToDelete = try context.fetch(request).first {
                context.delete(recipeToDelete)
                try context.save()
                return true
            }

        } catch let error {
            print(error)
            return false
        }

        return false
    }

    public func isFavorite(recipeLabel: String?) -> Bool {
        guard let label = recipeLabel else { return false }

        let request = CDRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "label LIKE %@", label)

        do {
            let fetchedRecipe = try context.fetch(request)
            return  fetchedRecipe.first?.isFavorite ?? false
        } catch {
            return false
        }
    }

    public func loadFavorites(completion: (Result<[CDRecipe]?, Error>) -> Void) {

        let request = CDRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorite == YES")

        do {
            let recipes = try context.fetch(request)

            completion(.success(recipes))
        } catch let error {
            completion(.failure(error))
        }
    }
}
