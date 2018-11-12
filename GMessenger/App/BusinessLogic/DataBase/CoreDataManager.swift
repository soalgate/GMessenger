//
//  CoreDataManager.swift
//  GMessenger
//
//  Created by Admin on 30/10/2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    func entityForName(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: self.context)!
    }
    
    func getEntitys<T: NSManagedObject>(entityType: T.Type, with predicate: NSPredicate?) throws -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        request.predicate = predicate
        do {
            return try context.fetch(request)            
        } catch {
            throw(error)
        }
    }
    
    // MARK: - Core Data stack
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GMessenger")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () throws {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                throw error
            }
        }
    }
}
