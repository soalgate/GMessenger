//
//  MockDataBase.swift
//  GMessenger
//
//  Created by Артем Полушин on 04.11.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

import Foundation

class MockRepository: Repository {
    
    var userId: UInt64 = 1
    var messageId: String = "11"
    
    var users: [User] = []
    var messages: [Message] = []
    
    init() {
        let user1 = User(id: 0, name: "Yoda", jid: "yoda@soalgate.ru")
        user1.isAuthorized = true
        let user2 = User(id: 1, name: "Vader", jid: "vader@soalgate.ru")
        
        users.append(user1)
        users.append(user2)
        
        let user1Message1 = Message(id: "11f1490a-e115-11e8-9f32-f2801f1b9fd1", senderId: 0, receiverId: 1, text: "Fear is the path to the dark side. Fear leads to anger; anger leads to hate; hate leads to suffering. I sense much fear in you.")
        let user2Message1 = Message(id: "75a36564-e115-11e8-9f32-f2801f1b9fd1", senderId: 1, receiverId: 0, text: "When I left you I was but the learner. Now I am the master.")
        
        user1Message1.isOutcome = true
        
        messages.append(user1Message1)
        messages.append(user2Message1)
    }
    
    func userIdIncrement() {
        userId += 1
    }
    
    func messageIdIncrement() {
        messageId += "1"
    }
    
    func getUsers() -> [User] {
        return users
    }
    
    func getUserById(id: UInt64) -> User? {
        return users.first(where: { user -> Bool in
            user.id == id
        })
    }
    
    func getUserByJID(jid: String) -> User? {
        return users.first(where: { user -> Bool in
            user.jid == jid
        })
    }
    
    func getCurrentUser() -> User? {
        return users.first(where: { user -> Bool in
            user.isAuthorized == true
        })
    }
    
    func getMessages() -> [Message] {
        return messages
    }
    
    func getMessage(id: String) -> Message? {
        return messages.first(where: { message -> Bool in
            message.id == id
        })
    }
    
    func saveUser(user: User) -> User {
        let usr = User(id: userId, name: user.name, jid: user.jid)
        users.append(usr)
        userIdIncrement()
        return usr
    }
    
    func saveMessage(message: Message) {
        let msg = message
        msg.id = messageId
        messages.append(msg)
        messageIdIncrement()
    }
}
