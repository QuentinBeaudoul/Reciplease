//
//  StubStoreManager.swift
//  RSearchTests
//
//  Created by Quentin on 17/03/2022.
//

import Foundation
import RStorage
import CoreData

class StubStoreManager: StoreProtocol {

    let modelName = StoreManager.modelName
    let bundleName = StoreManager.modelBundle

    lazy var persistentContainer: NSPersistentContainer = {

        let model = bundleName!.url(forResource: modelName, withExtension: "momd")!
        let managedObject = NSManagedObjectModel(contentsOf: model)
        let container = NSPersistentContainer(name: modelName, managedObjectModel: managedObject!)

        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")

        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        return container
    }()

    func saveRecipe() -> Bool {
        return true
    }

    func dropRecipe(_ recipeLabel: String?) -> Bool {
        return false
    }

    func loadFavorites(completion: (Result<[CDRecipe]?, Error>) -> Void) {
        completion(.success(nil))
    }

    func isFavorite(recipeLabel: String?) -> Bool {
        return false
    }
}
