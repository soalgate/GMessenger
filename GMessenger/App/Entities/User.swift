//
//  User.swift
//  GMessenger
//
//  Created by Артем Полушин on 27.10.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

import Foundation
import CoreData

@objc(User)
class User: AbstractContact {
    
    @NSManaged public var jid: String
    @NSManaged public var isAuthorized: Bool
    @NSManaged public var groups: [Int64]?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    convenience init() {
        // Описание сущности
        let entity = CoreDataManager.shared.entityForName(entityName: "User")
        
        // Создание нового объекта
        self.init(entity: entity, insertInto: CoreDataManager.shared.context)
    }
    
    convenience init(id: Int64 = 0, name: String, jid: String) {
        self.init()
        self.name = name
        self.jid = jid
    }
}
