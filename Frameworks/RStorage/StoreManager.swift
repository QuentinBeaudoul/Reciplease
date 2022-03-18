//
//  StoreManager.swift
//  RStorage
//
//  Created by Quentin on 09/03/2022.
//

import Foundation
import CoreData

public protocol StoreProtocol {
    func saveRecipe() -> Bool
    func dropRecipe(_ recipeLabel: String?) -> Bool
    func loadFavorites(completion: (Result<[CDRecipe]?, Error>) -> Void)
    func isFavorite(recipeLabel: String?) -> Bool
}

public final class StoreManager: StoreProtocol {
    public static let shared = StoreManager()

    private init() {}

    public static let modelName = "Reciplease"
    public static let modelBundle = Bundle(identifier: "Quentin.Beaudoul.RStorage")

    private lazy var persistentContainer: NSPersistentContainer = {

        let model = StoreManager.modelBundle!.url(forResource: StoreManager.modelName, withExtension: "momd")!
        let managedObject = NSManagedObjectModel(contentsOf: model)
        let container = NSPersistentContainer(name: StoreManager.modelName, managedObjectModel: managedObject!)

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        return container
    }()

    public var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    public func saveRecipe() -> Bool {
        let context = viewContext

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

        let context = viewContext

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
        let context = viewContext
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
            let recipes = try viewContext.fetch(request)

            completion(.success(recipes))
        } catch let error {
            completion(.failure(error))
        }
    }
}
