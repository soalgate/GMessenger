//
//  AbstractContact+CoreDataClass.swift
//  GMessenger
//
//  Created by Admin on 31/10/2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//
//

import Foundation
import CoreData

@objc(AbstractContact)
public class AbstractContact: NSManagedObject {
    
    @NSManaged public var name: String?
    @NSManaged public var id: Int64
    @NSManaged public var users: [Int64]?
    @NSManaged public var messages: [String]?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<AbstractContact> {
        return NSFetchRequest<AbstractContact>(entityName: "AbstractContact")
    }
    
    convenience init() {
        // Описание сущности
        let entity = CoreDataManager.shared.entityForName(entityName: "AbstractContact")
        
        // Создание нового объекта
        self.init(entity: entity, insertInto: CoreDataManager.shared.context)
    }
}
