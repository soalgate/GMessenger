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
        let user1 = User(id: 0, name: "Yoda", jid: "justeryoda@jabber.mipt.ru")
        user1.isAuthorized = true
        let user2 = User(id: 1, name: "Vader", jid: "justervader@jabber.mipt.ru")
        
        users.append(user1)
        users.append(user2)
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
        let msg = Message(id: messageId, senderId: message.senderId, receiverId: message.receiverId, text: message.text)
        messages.append(msg)
        messageIdIncrement()
    }
}
