//
//  StoreManager.swift
//  RStorage
//
//  Created by Quentin on 09/03/2022.
//

import Foundation
import CoreData
import Alamofire

protocol StoreProtocol {

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

        let recipeToSave = Recipe(context: viewContext)
        
        recipeToSave.copy(from: recipe)

        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }

    public func fetchRecipes(completion: (Result<[Recipe]?, Error>) -> Void) {

        let request = Recipe.fetchRequest()

        do {
            let recipes = try viewContext.fetch(request)
            
            completion(.success(recipes))
        } catch let error {
            completion(.failure(error))
        }
    }
}
