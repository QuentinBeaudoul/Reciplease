//
//  StubStoreManager.swift
//  RSearchTests
//
//  Created by Quentin on 17/03/2022.
//

import Foundation
import RStorage
import CoreData

class StubCoreDataService: CoreDataServiceProtocol {

    private let modelName = "Reciplease"
    private let modelBundle = Bundle(identifier: "Quentin.Beaudoul.RStorage")

    lazy var persistentContainer: NSPersistentContainer = {

        let model = modelBundle!.url(forResource: modelName, withExtension: "momd")!
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

    var context: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }

}
