//
//  Message.swift
//  GMessenger
//
//  Created by Артем Полушин on 27.10.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//
import Foundation
import CoreData

@objc(Message)
public class Message: NSManagedObject {
    
    @NSManaged public var id: String?
    @NSManaged public var senderId: Int64
    @NSManaged public var receiverId: Int64
    @NSManaged public var text: String
    @NSManaged public var isOutcome: Bool
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }
    convenience init() {
        // Описание сущности
        let entity = CoreDataManager.shared.entityForName(entityName: "Message")
        
        // Создание нового объекта
        self.init(entity: entity, insertInto: CoreDataManager.shared.context)
    }
    convenience init(id: String, senderId: Int64, receiverId: Int64, text: String) {
        self.init()
        self.id = id
        self.senderId = senderId
        self.receiverId = receiverId
        self.text = text
    }
    convenience init(senderId: Int64, receiverId: Int64, text: String) {
        self.init()
        self.senderId = senderId
        self.receiverId = receiverId
        self.text = text
    }
}
