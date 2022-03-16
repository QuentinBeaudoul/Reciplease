//
//  StoreManager.swift
//  RStorage
//
//  Created by Quentin on 09/03/2022.
//

import Foundation
import CoreData

public protocol StoreProtocol {
    func saveRecipe(_ recipe: Recipe) -> Bool
    func dropRecipe(_ recipe: Recipe) -> Bool
    func loadFavorites(completion: (Result<[Recipe]?, Error>) -> Void)
    func isFavorite(recipe: Recipe?) -> Bool
}

public final class StoreManager: StoreProtocol {
    public static let shared = StoreManager()

    private init() {}

    private let modelName = "Reciplease"
    private let modelBundle = Bundle(identifier: "Quentin.Beaudoul.RStorage")

    private lazy var persistentContainer: NSPersistentContainer = {

        let model = modelBundle!.url(forResource: modelName, withExtension: "momd")!
        let managedObject = NSManagedObjectModel(contentsOf: model)
        let container = NSPersistentContainer(name: modelName, managedObjectModel: managedObject!)

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        return container
    }()

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    public func saveRecipe(_ recipe: Recipe) -> Bool {
        let context = viewContext

        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }

    public func dropRecipe(_ recipe: Recipe) -> Bool {
        let context = viewContext

        context.delete(recipe)

        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }

    public func isFavorite(recipe: Recipe?) -> Bool {
        guard let recipe = recipe else { return false }
        let context = viewContext
        let request = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "label LIKE %@", recipe.label ?? "")

        do {
            let fetchedRecipe = try context.fetch(request)
            return  fetchedRecipe.first?.isFavorite ?? false
        } catch {
            return false
        }
    }

    public func loadFavorites(completion: (Result<[Recipe]?, Error>) -> Void) {

        let request = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorite == YES")

        do {
            let recipes = try viewContext.fetch(request)

            completion(.success(recipes))
        } catch let error {
            completion(.failure(error))
        }
    }
}
