//
//  StoreManager.swift
//  RStorage
//
//  Created by Quentin on 09/03/2022.
//

import Foundation
import CoreData

protocol StoreProtocol {

}

public final class StoreManager: StoreProtocol {
    public static let shared = StoreManager()

    private init() {}

    private lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "Reciplease")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      })
      return container
    }()

    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}
