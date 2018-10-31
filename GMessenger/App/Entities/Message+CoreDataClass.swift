//
//  Message+CoreDataClass.swift
//  GMessenger
//
//  Created by Admin on 31/10/2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Message)
public class Message: NSManagedObject {
    
    @NSManaged public var id: String?
    @NSManaged public var senderId: Int64
    @NSManaged public var receiverId: Int64
    @NSManaged public var text: String?
   
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }
    convenience init() {
        // Описание сущности
        let entity = CoreDataManager.shared.entityForName(entityName: "Message")
        
        // Создание нового объекта
        self.init(entity: entity, insertInto: CoreDataManager.shared.context)
    }
}
